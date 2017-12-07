class ActivityList::Project < ApplicationRecord
  belongs_to :project, class_name: '::Project', foreign_key: :project_id

  has_many :activities, -> { order(id: :desc) },
    class_name: 'ProjectActivity', foreign_key: :activity_list_project_id,
    dependent: :destroy

  delegate :name, to: :project, prefix: true

  class << self

    def daily_list_for_user(user_id)
      project_ids = Project.project_ids_for_user(user_id)
      all_days = days_for_projects(project_ids)

      days =
        if block_given?
          yield(all_days)
        else
          all_days
        end

      daily_list_by_day_and_project(days, project_ids)
    end

    def days_for_projects(project_ids)
      select(:date).where(project_id: project_ids).group(:date).order(date: :desc)
    end

    def daily_list_by_day_and_project(days, project_ids)
      project_list = where(date: days, project_id: project_ids).order(date: :desc, updated_at: :desc)
      ActivityList::Daily.parse(project_list)
    end
  end
end
