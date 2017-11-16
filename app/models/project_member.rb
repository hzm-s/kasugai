class ProjectMember < ApplicationRecord
  belongs_to :user

  delegate :name, to: :user
  delegate :initials, to: :user
  delegate :theme, to: :user

  def same_user?(user)
    user_id == user.id
  end
end
