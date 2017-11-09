class Project::BookmarkedIssuesController < Project::BaseController

  def index
    @bookmarked_issues = BookmarkedIssue.for_project(current_project.id)
    render partial: 'list'
  end

  def create
    issue = Issue.find(params[:issue_id])
    ProjectService.bookmark_issue(issue)
  end
end
