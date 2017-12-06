class UserUpdatePropagationJob < ApplicationJob
  queue_as :default

  def perform(user)
    user.project_activities.each(&:touch)
  end
end
