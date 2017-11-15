class IssueCommentService < ApplicationService

  def initialize(mailer: IssueCommentMailer)
    @mailer = mailer
  end

  def post(user, issue, params)
    return failure(params: params) unless params.valid?

    comment = issue.comments.build(user_id: user.id, content: params.content)
    comment.save!

    issue.project.members_without(user).each do |member|
      @mailer.posted(member.user, comment).deliver_later!
    end

    success(comment: comment)
  end

  def delete(issue)
    issue.destroy!
  end
end
