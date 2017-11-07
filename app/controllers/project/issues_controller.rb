class Project::IssuesController < Project::BaseController
  before_action :ensure_signed_in
  before_action :ensure_project_member

  def index
    @issues = Issue.all
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

  private

    def form_params
      params.require(:form).permit(:title, :content)
    end
end
