class Issue::CommentsController < Project::BaseController
  before_action :ensure_signed_in, only: [:index, :create, :edit, :update, :destroy]
  before_action :ensure_project_member, only: [:index, :create, :edit, :update, :destroy]

  helper_method :current_issue

  def index
    @comments = current_issue.comments
    render layout: false
  end

  def create
    form = IssueCommentForm.new(form_params)
    @result = IssueCommentService.post(current_project_member, current_issue, form)
    if @result.succeeded?
      @comment = @result.comment
      @form = IssueCommentForm.new
    else
      @form = @result.params
    end
  end

  def edit
    @comment = IssueComment.find(params[:id])
    @form = IssueCommentForm.new(content: @comment.content)
  end

  def update
    form = IssueCommentForm.new(form_params)
    @comment = IssueComment.find(params[:id])
    result = IssueCommentService.update(@comment, form)
    if result.succeeded?
      @comment = result.comment
    else
      @form = result.params
      render :edit
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
