class ProjectMember < ApplicationRecord
  belongs_to :project
  belongs_to :user

  delegate :email, to: :user
  delegate :name, to: :user
  delegate :initials, to: :user
  delegate :theme, to: :user

  class << self

    def find_by_user_and_project(user_id, project_id)
      includes(user: :account)
        .find_by(user_id: user_id, project_id: project_id)
    end
  end
end
