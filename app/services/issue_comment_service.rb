class IssueCommentService < ApplicationService

  def initialize(mailer: IssueCommentMailer)
    @mailer = mailer
  end

  def post(project_member, issue, params)
    return failure(params: params) unless params.valid?

    comment = issue.comments.build(user_id: project_member.user_id, content: params.content)
    comment.save!

    issue.project.members_without(project_member).each do |member|
      @mailer.posted(member.user, comment).deliver_later!
    end

    success(comment: comment)
  end

  def delete(issue)
    issue.destroy!
  end
end
