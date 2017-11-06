class ProjectsController < ApplicationController

  def index
    @projects = Project.for_user(current_user.id)
  end

  def new
    @form = CreateProjectForm.new
  end

  def create
    form = CreateProjectForm.new(form_params)
    ProjectService.create(current_user, form)
    redirect_to projects_url, notice: flash_message
  end

  private

    def form_params
      params.require(:form).permit(:name, :description)
    end
end
