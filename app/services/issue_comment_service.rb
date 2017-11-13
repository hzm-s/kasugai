class IssueCommentService < ApplicationService

  def post(user, issue, params)
    return failure(params: params) unless params.valid?

    comment = issue.comments.build(user: user, content: params.content)
    comment.save!
    success(comment: comment)
  end
end
