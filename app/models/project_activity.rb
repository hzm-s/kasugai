class ProjectActivity < ApplicationRecord
  belongs_to :project
  belongs_to :user

  delegate :name, to: :project, prefix: true
  delegate :name, to: :user, prefix: true
  delegate :initials, to: :user, prefix: true
  delegate :present_target, to: :detail

  has_one :issue, class_name: 'ProjectActivities::Issue', dependent: :destroy
  has_one :issue_comment, class_name: 'ProjectActivities::IssueComment', dependent: :destroy

  class << self

    def dailies_for_user(user_id)
      records =
        includes(:project, :issue)
          .where(project_id: Project.project_ids_for_user(user_id))
          .order(created_at: :desc)
      ActivityList.group_by_date(records)
    end
  end

  private

    def detail
      @_detail ||= [issue, issue_comment].compact.first
    end
end
