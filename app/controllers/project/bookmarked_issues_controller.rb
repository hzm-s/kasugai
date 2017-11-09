class Project::BookmarkedIssuesController < Project::BaseController
  before_action :ensure_signed_in, only: [:index, :create, :destroy]

  def index
    @bookmarked_issues = BookmarkedIssue.for_project(current_project.id)
    render partial: 'list'
  end

  def create
    issue = Issue.find(params[:issue_id])
    ProjectService.bookmark_issue(issue)
  end

  def destroy
    issue = Issue.find(params[:id])
    ProjectService.unbookmark_issue(issue)
  end
end
