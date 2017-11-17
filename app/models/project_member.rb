class ProjectMember < ApplicationRecord
  belongs_to :project
  belongs_to :user

  delegate :email, to: :user
  delegate :name, to: :user
  delegate :initials, to: :user
  delegate :theme, to: :user
end
