class ActivityList::Project < ApplicationRecord
  belongs_to :project, class_name: '::Project', foreign_key: :project_id

  has_many :activities, -> { order(id: :desc) },
    class_name: 'ProjectActivity', foreign_key: :activity_list_project_id,
    dependent: :destroy

  delegate :name, to: :project, prefix: true

  class << self

    def daily_list_for_user(user_id, page)
      list = daily_list_for_user_without_page(user_id).page(page).per(3)
      ActivityList::Daily.parse(list)
    end

    def daily_list_for_user_without_page(user_id)
      project_ids = Project.project_ids_for_user(user_id)
      where(project_id: project_ids).order(date: :desc, updated_at: :desc)
    end
  end
end
