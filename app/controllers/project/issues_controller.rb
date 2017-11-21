class Project::IssuesController < Project::BaseController
  layout 'project'

  before_action :ensure_signed_in
  before_action :ensure_project_member

  helper_method :current_issue

  def index
    @issues = Issue.for_project(current_project.id)
    @closed_issues_count = ClosedIssue.count_for_project(current_project.id)
  end

  def show
    @issue = current_issue
    @issue_form = IssueForm.new(title: @issue.title, content: @issue.content)
    @comment_form = IssueCommentForm.new
  end

  def new
    @form = IssueForm.new
  end

  def create
    form = IssueForm.new(form_params)
    result = IssueService.create(current_project_member, form)
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
    @result = IssueService.update(current_issue, form)
    if @result.succeeded?
      respond_to do |f|
        f.html { redirect_to project_issues_url, notice: flash_message }
        f.js
      end
    else
      @issue = current_issue
      @form = @result.params
      respond_to do |f|
        f.html { render :edit }
        f.js
      end
    end
  end

  def destroy
    IssueService.delete(current_issue)
    redirect_to project_issues_url, notice: flash_message
  end

  private

    def form_params
      params.require(:form).permit(:title, :content, :field)
    end

    def current_issue
      @current_issue ||= Issue.includes(:closed).find(params[:id])
    end
end
