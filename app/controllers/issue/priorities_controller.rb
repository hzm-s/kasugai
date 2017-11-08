class Issue::PrioritiesController < Project::BaseController
  before_action :ensure_signed_in

  def update
    issue = Issue.find(params[:issue_id])
    IssueService.change_priority(issue, params[:new_position])
    head :ok
  end
end
