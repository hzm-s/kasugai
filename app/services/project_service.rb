class ProjectService < ApplicationService

  def create(user, params)
    return failure(params: params) unless params.valid?

    project = ProjectFactory.create(user, params)
    project.save!

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

  def delete_member(project, project_member)
    project.delete_member(project_member)
    success
  end
end
