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
    issue.change_priority_to(new_position)
  end

  def bookmark(issue)
    issue.bookmark
  end

  def unbookmark(issue)
    issue.unbookmark
  end

  def close(issue)
    issue.close
  end

  def reopen(issue)
    issue.reopen
  end
end
