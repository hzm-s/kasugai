class IssueCommentsChannel < ApplicationCable::Channel

  def follow(data)
    stop_all_streams
    issue = Issue.find(data['issue_id'])
    stream_for issue
  end

  def unfollow
    stop_all_streams
  end
end
