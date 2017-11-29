class IssueCommentsChannel < ApplicationCable::Channel

  def follow(data)
    stop_all_streams

    @issue = Issue.find(data['issue_id'])
    @current_project_member = current_user.as_member_of(@issue.project)
    @current_project_member.appear_in_issue(@issue)

    stream_for_other_users(current_user.id, @issue)
  end

  def unfollow
    @current_project_member&.away_from_issue(@issue) if @issue
    stop_all_streams
  end
end
