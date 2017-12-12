class IssueService < ApplicationService

  def initialize(notifier: IssueNotificationJob)
    @notifier = notifier
  end

  def create(project_member, params)
    return failure(params: params) unless params.valid?

    issue = IssueFactory.create(project_member, params)
    issue_list = project_member.project.issue_list

    transaction do
      issue.save!
      issue_list.add(issue).save!
      ProjectActivities::Issue.record!(:created, project_member, issue)
    end

    success(issue: issue)
  end

  def update(project_member, issue, params)
    return failure(params: params) unless params.valid?

    transaction do
      issue.update!(title: params.title, content: params.content)
      IssueUpdatePropagationJob.perform_later(issue)
      ProjectActivities::Issue.record!(:updated, project_member, issue.reload)
    end

    success
  end

  def delete(project_member, issue)
    transaction do
      issue.destroy!
      ProjectActivities::Issue.record!(:deleted, project_member, issue)
    end
  end

  def change_priority(issue, new_position)
    list = issue.project.issue_list
    list.change_priority_position!(issue, new_position)
  end

  def close(project_member, issue)
    issue_list = project_member.project.issue_list
    closed_issue_list = project_member.project.closed_issue_list

    transaction do
      issue_list.remove!(issue)
      closed_issue_list.add(issue).save!
      ProjectActivities::Issue.record!(:closed, project_member, issue)
    end
  end

  def reopen(project_member, issue)
    issue_list = project_member.project.issue_list
    closed_issue_list = project_member.project.closed_issue_list

    transaction do
      closed_issue_list.remove!(issue)
      issue_list.add(issue).save!
      issue.touch
      ProjectActivities::Issue.record!(:reopened, project_member, issue)
    end
  end
end
