class ProjectsController < ApplicationController
  before_action :ensure_signed_in
  before_action :ensure_project_member, only: [:show]

  def index
    @projects = Project.for_user(current_user.id)
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @form = ProjectForm.new
  end

  def create
    form = ProjectForm.new(form_params)
    result = ProjectService.create(current_user, form)
    if result.succeeded?
      redirect_to projects_url, notice: flash_message
    else
      @form = result.params
      render :new
    end
  end

  private

    def form_params
      params.require(:form).permit(:name, :description)
    end

    def ensure_project_member
      project = Project.find(params[:id])
      unless project.member?(current_user)
        redirect_to projects_url
      end
    end
end
