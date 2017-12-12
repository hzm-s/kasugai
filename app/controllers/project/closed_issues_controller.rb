class Project::ClosedIssuesController < Project::BaseController
  layout 'project'

  before_action :ensure_signed_in, only: [:index, :create, :destroy]
  before_action :ensure_project_member, only: [:index, :create, :destroy]

  helper_method :current_issue

  def index
    @list = current_project.closed_issue_list
  end

  def create
    issue = Issue.find(params[:issue_id])
    IssueService.close(current_project_member, issue)
    redirect_to project_issues_url(current_project), notice: flash_message
  end

  def destroy
    issue = Issue.find(params[:id])
    IssueService.reopen(current_project_member, issue)
    redirect_to project_issue_url(current_project, issue), notice: flash_message
  end

  private

    def current_issue
      @current_issue ||= Issue.find_closed(params[:id])
    end
end
