class ProjectMember < ApplicationRecord
  belongs_to :user

  delegate :initials, to: :user
  delegate :name, to: :user
end
