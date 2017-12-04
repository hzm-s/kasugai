class IssueService < ApplicationService

  def initialize(notifier: IssueNotificationJob)
    @notifier = notifier
  end

  def create(project_member, params)
    return failure(params: params) unless params.valid?

    issue = IssueFactory.create(project_member, params)
    transaction do
      issue.save!
      OpenedIssue.add!(issue)
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
    OpenedIssue.change_priority_position!(issue, new_position)
  end

  def close(issue)
    transaction do
      OpenedIssue.delete!(issue)
      ClosedIssue.add!(issue)
    end
  end

  def reopen(issue)
    transaction do
      ClosedIssue.delete!(issue)
      OpenedIssue.add!(issue)
    end
  end

  def bookmark(issue)
    BookmarkedIssue.add!(issue)
  end

  def unbookmark(issue)
    BookmarkedIssue.delete!(issue)
  end
end
