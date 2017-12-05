class ActivityList::Project < ApplicationRecord
  belongs_to :project, class_name: '::Project', foreign_key: :project_id

  has_many :activities, -> { order(id: :desc) },
    class_name: 'ProjectActivity', foreign_key: :activity_list_project_id,
    dependent: :destroy

  delegate :name, to: :project, prefix: true

  class << self

    def for_user(user_id)
      project_ids = Project.project_ids_for_user(user_id)
      all = where(project_id: project_ids).order(date: :desc, updated_at: :desc)
      ActivityList::Daily.parse(all)
    end
  end
end
