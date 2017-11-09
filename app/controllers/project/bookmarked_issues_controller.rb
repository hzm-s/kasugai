class Project::BookmarkedIssuesController < Project::BaseController

  def index
    render partial: 'list'
  end

  def create
    issue = Issue.find(params[:issue_id])
    ProjectService.bookmark_issue(issue)
  end
end
