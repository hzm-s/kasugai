class ProjectActivity < ApplicationRecord
  belongs_to :project_list, class_name: 'ActivityList::Project', foreign_key: 'activity_list_project_id'
  belongs_to :user

  delegate :project_name, to: :project_list

  delegate :name, to: :user, prefix: true
  delegate :initials, to: :user, prefix: true

  delegate :present_target, to: :detail
  delegate :present_optional_information, to: :detail

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

    def record_with_detail!(project_member, activity)
      attrs = {
        project_id: project_member.project_id,
        user_id: project_member.user_id,
        activity: activity
      }
      ProjectActivity.new(attrs) do |pa|
        yield(pa)
        pa.save!
      end
    end
  end

  private

    def detail
      @_detail ||= [issue, issue_comment].compact.first
    end
end
