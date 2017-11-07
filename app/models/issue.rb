class Issue < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: 'User', foreign_key: :user_id

  class << self

    def for_project(project_id)
      where(project_id: project_id)
    end
  end
end
