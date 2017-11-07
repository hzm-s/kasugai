class ProjectsController < Project::BaseController
  before_action :ensure_signed_in
  before_action :ensure_project_existence, only: [:show]
  before_action :ensure_project_member, only: [:show]

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

  private

    def form_params
      params.require(:form).permit(:name, :description)
    end

    def current_project
      @current_project ||= Project.find_by(id: params[:id])
    end
end
