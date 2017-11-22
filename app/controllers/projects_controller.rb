class ProjectsController < Project::BaseController
  layout 'project', only: [:edit]

  before_action :ensure_signed_in
  before_action :ensure_project_existence, only: [:show, :edit, :update, :destroy]
  before_action :ensure_project_member, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.for_user(current_user.id)
  end

  def show
    @project = current_project
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

  def edit
    @form = ProjectForm.fill(current_project)
  end

  def update
    form = ProjectForm.new(form_params)
    result = ProjectService.update(current_project, form)
    if result.succeeded?
      redirect_to edit_project_url(current_project), notice: flash_message
    else
      @form = result.params
      render :edit, layout: 'project'
    end
  end

  def destroy
    ProjectService.delete(current_project)
    redirect_to projects_url, notice: flash_message
  end

  private

    def form_params
      params.require(:form).permit(:name, :description)
    end
end
