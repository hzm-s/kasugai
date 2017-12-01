class ProjectActivity < ApplicationRecord
  belongs_to :project
  belongs_to :user

  delegate :name, to: :project, prefix: true
  delegate :name, to: :user, prefix: true
  delegate :initials, to: :user, prefix: true
  delegate :link_text, to: :detail
  delegate :link_url, to: :detail

  has_one :issue, class_name: 'ProjectActivities::Issue', dependent: :destroy

  class << self

    def dailies_for_user(user_id)
      records =
        includes(:project, :issue)
          .where(project_id: Project.project_ids_for_user(user_id))
          .order(created_at: :desc)

      records
        .group_by { |r| r.created_at.to_date }
        .map { |date, subset| DailyActivityList.group_by_project(date, subset) }
    end
  end

  private

    def detail
      @_detail ||=
        [issue].compact.first
    end
end
