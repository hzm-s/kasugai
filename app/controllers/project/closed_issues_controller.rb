class Project::ClosedIssuesController < Project::BaseController
  layout 'project'

  before_action :ensure_signed_in, only: [:index, :create]
  before_action :ensure_project_member, only: [:index, :create]

  def index
    @issues = ClosedIssue.for_project(current_project.id)
  end

  def create
    IssueService.close(current_issue)
    redirect_to project_issues_url(current_project), notice: flash_message
  end

  private

    def current_issue
      Issue.find(params[:issue_id])
    end
end
