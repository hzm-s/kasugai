class Project::ClosedIssuesController < Project::BaseController
  before_action :ensure_signed_in, only: [:create]
  before_action :ensure_project_member, only: [:create]

  def create
    IssueService.close(current_issue)
    redirect_to project_issues_url(current_project), notice: flash_message
  end

  private

    def current_issue
      Issue.find(params[:issue_id])
    end
end
