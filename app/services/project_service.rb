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

  def add_member(project, user_id)
    added_member = project.add_member(user_id)
    success(member: added_member)
  end

  def update(project, params)
    return failure(params: params) unless params.valid?

    project.name = params.name
    project.description = params.description
    project.save!

    success
  end

  def delete(project)
    project.destroy!
    success
  end

  def delete_member(project_member)
    project_member.destroy!
    success
  end
end
