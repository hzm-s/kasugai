class IssueService < ApplicationService
  
  def create(user, project, params)
    issue =
      Issue.create!(
        project: project,
        author: user,
        title: params.title,
        content: params.content
      )
  end
end
