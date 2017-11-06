class ProjectMember < ApplicationRecord
  belongs_to :user

  delegate :initials, to: :user
  delegate :name, to: :user

  def same_user?(user)
    user_id == user.id
  end
end
