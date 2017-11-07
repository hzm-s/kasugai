class IssueService < ApplicationService
  
  def create(user, project, params)
    return failure(params: params) unless params.valid?

    issue =
      Issue.create!(
        project: project,
        author: user,
        title: params.title,
        content: params.content
      )
    success
  end
end
