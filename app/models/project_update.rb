class ProjectUpdate < ApplicationRecord
  serialize :detail

  belongs_to :project
  belongs_to :user

  delegate :name, to: :project, prefix: true
  delegate :name, to: :user, prefix: true
  delegate :description, to: :detail

  class << self

    def for_user(user_id)
      project_ids = Project.project_ids_for_user(user_id)
      includes(:project, :user)
        .where(project_id: project_ids)
        .order(created_at: :desc)
    end
  end
end
