class Project::ArchivedIssuesController < Project::BaseController

  def create
    IssueService.archive(current_issue)
    redirect_to project_issues_url(current_project), notice: flash_message
  end

  private

    def current_issue
      Issue.find(params[:issue_id])
    end
end
