class UserUpdatePropagationJob < ApplicationJob
  queue_as :default

  def perform(user)
    user.project_members.each(&:touch)
    user.project_activities.each(&:touch)
    user.issue_comments.each(&:touch)
  end
end
