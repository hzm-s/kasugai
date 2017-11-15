class IssueCommentService < ApplicationService

  def post(user, issue, params)
    return failure(params: params) unless params.valid?

    comment = issue.comments.build(user_id: user.id, content: params.content)
    comment.save!
    success(comment: comment)
  end

  def delete(issue)
    issue.destroy!
  end
end
