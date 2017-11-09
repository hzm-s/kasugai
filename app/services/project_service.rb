class ProjectService < ApplicationService

  def create(user, params)
    return failure(params: params) unless params.valid?

    project =
      Project.new(name: params.name, description: params.description) do |p|
        p.id = SecureRandom.hex(8)
        p.members.build(user_id: user.id)
        p.save!
      end

    success(project: project)
  end

  def bookmark_issue(issue)
    issue.bookmark
  end

  def unbookmark_issue(issue)
    issue.unbookmark
  end
end
