class ProjectsController < ApplicationController
  before_action :ensure_signed_in

  def index
    @projects = Project.for_user(current_user.id)
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
end
