class IssueService < ApplicationService

  def create(user, project, params)
    return failure(params: params) unless params.valid?

    issue =
      Issue.create!(
        id: SecureRandom.hex(8),
        project: project,
        author: user,
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
end
