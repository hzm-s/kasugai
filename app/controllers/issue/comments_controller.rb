class Issue::CommentsController < Project::BaseController
  helper_method :current_issue

  def index
    @comments = IssueComment.all
    render layout: false
  end

  def new
    @form = IssueCommentForm.new
    render layout: false
  end

  def create
    form = IssueCommentForm.new(form_params)
    result = IssueCommentService.post(current_user, current_issue, form)
    @comment = result.comment
    @form = IssueCommentForm.new
  end

  private

    def form_params
      params.require(:form).permit(:content)
    end

    def current_issue
      @current_issue ||= Issue.find(params[:issue_id])
    end
end
