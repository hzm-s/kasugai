class Issue::PrioritiesController < ApplicationController

  def update
    issue = Issue.find(params[:issue_id])
    IssueService.change_priority(issue, params[:new_position])
    head :ok
  end
end
