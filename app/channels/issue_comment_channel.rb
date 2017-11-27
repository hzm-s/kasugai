class IssueCommentChannel < ApplicationCable::Channel
  def follow(data)
    stop_all_streams
    stream_from "issues:#{data['issue_id']}:comments"
  end

  def unfollow
    stop_all_streams
  end
end
