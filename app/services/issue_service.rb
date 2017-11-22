class IssueService < ApplicationService

  def create(project_member, params)
    return failure(params: params) unless params.valid?

    issue = IssueFactory.create(project_member, params)
    transaction do
      issue.save!
      OpenedIssue.add!(issue)
    end

    success(issue: issue)
  end

  def update(issue, params)
    return failure(params: params) unless params.valid?

    issue.update!(title: params.title, content: params.content)
    success
  end

  def delete(issue)
    issue.destroy!
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
