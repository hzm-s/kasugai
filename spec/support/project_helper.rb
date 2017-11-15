module ProjectHelper
  def create_project(user, attrs)
    ProjectService.create(user, ProjectForm.new(attrs)).project
  end

  def add_project_member(project, user)
    ProjectService.add_member(project, user.id)
  end
end

RSpec.configure do |c|
  c.include ProjectHelper
end
