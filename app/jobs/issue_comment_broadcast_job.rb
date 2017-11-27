class IssueCommentBroadcastJob < ApplicationJob
  queue_as :default

  def perform(comment)
    new_comment_html =
      ApplicationController
        .renderer
        .render(partial: 'issue/comments/others_comment', locals: { comment: comment })

    ActionCable.server.broadcast "issues:#{comment.issue_id}:comments", html: new_comment_html
  end
end
