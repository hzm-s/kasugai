module ProjectHelper
  def create_project(user, attrs)
    ProjectService.create(user, ProjectForm.new(attrs)).project
  end
end

RSpec.configure do |c|
  c.include ProjectHelper
end
