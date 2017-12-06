class ActivityList::Project < ApplicationRecord
  belongs_to :project, class_name: '::Project', foreign_key: :project_id

  has_many :activities, -> { order(id: :desc) },
    class_name: 'ProjectActivity', foreign_key: :activity_list_project_id,
    dependent: :destroy

  delegate :name, to: :project, prefix: true

  class << self

    def daily_list_for_user(user_id, page = 1)
      project_ids = Project.project_ids_for_user(user_id)
      dates = date_scope(project_ids, page)
      list = where(date: dates, project_id: project_ids).order(date: :desc, updated_at: :desc)
      ActivityList::Daily.parse(list)
    end

    private

      def date_scope(project_ids, page)
        select(:date)
          .where(project_id: project_ids)
          .group(:date).order(date: :desc)
          .page(page).per(3)
      end
  end
end
