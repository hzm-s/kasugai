class IssueNotificationJob < ApplicationJob
  queue_as :default

  def perform(issue)
    issue.project.members_without(issue.author_project_member).each do |member|
      IssueMailer.created(member, issue).deliver_later!
    end
  end
end
