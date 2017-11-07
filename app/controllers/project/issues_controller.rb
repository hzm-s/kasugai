class Project::IssuesController < Project::BaseController
  layout 'project'

  before_action :ensure_signed_in, only: [:new, :create, :index]
  before_action :ensure_project_member, only: [:new, :create, :index]

  helper_method :current_issue

  def index
    @issues = Issue.for_project(current_project.id)
  end

  def new
    @form = IssueForm.new
  end

  def create
    form = IssueForm.new(form_params)
    result = IssueService.create(current_user, current_project, form)
    if result.succeeded?
      redirect_to project_issues_url(project_id: current_project.id), notice: flash_message
    else
      @form = result.params
      render :new
    end
  end

  def edit
    @form = IssueForm.fill(current_issue)
  end

  def update
    form = IssueForm.new(form_params)
    IssueService.update(current_issue, form)
    redirect_to project_issues_url, notice: flash_message
  end

  private

    def form_params
      params.require(:form).permit(:title, :content)
    end

    def current_issue
      @current_issue ||= Issue.find(params[:id])
    end
end
