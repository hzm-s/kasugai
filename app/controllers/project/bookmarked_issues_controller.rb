class Project::BookmarkedIssuesController < Project::BaseController
  before_action :ensure_signed_in, only: [:index, :create, :destroy]
  before_action :ensure_project_member, only: [:index, :create, :destroy]

  def index
    @list = current_project.bookmarked_issue_list
    render partial: 'list'
  end

  def create
    @issue = Issue.find(params[:issue_id])
    BookmarkedIssueService.add(current_project_member, @issue)
  end

  def destroy
    @issue = Issue.find(params[:id])
    BookmarkedIssueService.remove(current_project_member, @issue)
  end
end
