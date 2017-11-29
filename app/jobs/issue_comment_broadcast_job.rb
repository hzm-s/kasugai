class IssueCommentBroadcastJob < ApplicationJob
  queue_as :default

  def perform(comment)
    new_comment_html =
      ApplicationController
        .renderer
        .render(partial: 'issue/comments/others_comment', locals: { comment: comment })
    IssueCommentsChannel.broadcast_to(
      comment.issue,
      html: new_comment_html,
      publisher_id: comment.author_id
    )
  end
end
