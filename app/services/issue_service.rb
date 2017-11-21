class IssueService < ApplicationService

  def create(project_member, params)
    return failure(params: params) unless params.valid?

    issue = Issue.create!(
      id: SecureRandom.hex(8),
      project: project_member.project,
      author: project_member.user,
      title: params.title,
      content: params.content
    )

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
