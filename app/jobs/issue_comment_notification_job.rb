class IssueCommentNotificationJob < ApplicationJob
  queue_as :default

  def perform(comment)
    comment.observers.each do |member|
      IssueCommentMailer.posted(member, comment).deliver_later!
    end
  end
end
