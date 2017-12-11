class IssueService < ApplicationService

  def initialize(notifier: IssueNotificationJob)
    @notifier = notifier
  end

  def create(project_member, params)
    return failure(params: params) unless params.valid?

    issue = IssueFactory.create(project_member, params)
    list = project_member.project.issue_list

    transaction do
      issue.save!
      list.add(issue)
      list.save!
      ProjectActivities::Issue.record!(:created, project_member, issue)
    end

    success(issue: issue)
  end

  def update(project_member, issue, params)
    return failure(params: params) unless params.valid?

    transaction do
      issue.update!(title: params.title, content: params.content)
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
    project = project_member.project
    issue_list = project.issue_list
    closed_issue_list = project.closed_issue_list

    closed_issue_list.add(issue)

    transaction do
      issue_list.remove!(issue)
      issue_list.save!
      closed_issue_list.save!
      ProjectActivities::Issue.record!(:closed, project_member, issue)
    end
  end

  def reopen(project_member, issue)
    transaction do
      ClosedIssue.delete!(issue)
      OpenedIssue.add!(issue)
      ProjectActivities::Issue.record!(:reopened, project_member, issue)
    end
  end

  def bookmark(issue)
    BookmarkedIssue.add!(issue)
  end

  def unbookmark(issue)
    BookmarkedIssue.delete!(issue)
  end
end
