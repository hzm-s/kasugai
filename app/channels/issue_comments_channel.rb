class IssueCommentsChannel < ApplicationCable::Channel

  def follow(data)
    stop_all_streams
    issue = Issue.find(data['issue_id'])
    stream_for_other_users(current_user.id, issue)
  end

  def unfollow
    stop_all_streams
  end
end
