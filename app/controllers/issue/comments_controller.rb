class Issue::CommentsController < Project::BaseController
  before_action :ensure_signed_in, only: [:index, :create, :destroy]
  before_action :ensure_project_member, only: [:index, :create, :destroy]

  helper_method :current_issue

  def index
    @comments = current_issue.comments
    render layout: false
  end

  def create
    form = IssueCommentForm.new(form_params)
    @result = IssueCommentService.post(current_user, current_issue, form)
    if @result.succeeded?
      @comment = @result.comment
      @form = IssueCommentForm.new
    else
      @form = @result.params
    end
  end

  def destroy
    @comment = IssueComment.find(params[:id])
    IssueCommentService.delete(@comment)
  end

  private

    def form_params
      params.require(:form).permit(:content)
    end

    def current_project
      @current_project ||= current_issue.project
    end

    def current_issue
      @current_issue ||= Issue.find(params[:issue_id])
    end
end
