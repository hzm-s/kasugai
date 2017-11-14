class Project::BookmarkedIssuesController < Project::BaseController
  before_action :ensure_signed_in, only: [:index, :create, :destroy]
  before_action :ensure_project_member, only: [:index, :create, :destroy]

  def index
    @bookmarked_issues = Issue.bookmarked(current_project.id)
    render partial: 'list'
  end

  def create
    @issue = Issue.find(params[:issue_id])
    IssueService.bookmark(@issue)
  end

  def destroy
    @issue = Issue.find(params[:id])
    IssueService.unbookmark(@issue)
  end
end
