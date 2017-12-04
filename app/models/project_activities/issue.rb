class ProjectActivities::Issue < ApplicationRecord
  include ProjectActivityDetail

  def self.record!(activity, project_member, issue)
    transaction do
      daily = ActivityList::Daily.find_or_create_by!(date: Time.current.to_date)
      project = ActivityList::Project.find_or_create_by!(activity_list_daily_id: daily.id, project_id: project_member.project_id)
      ProjectActivity.new(
        activity_list_project_id: project.id,
        user_id: project_member.user_id,
        activity: "issues.#{activity}"
      ) do |pa|
        pa.build_issue(issue_id: issue.id, title: issue.title)
        pa.save!
      end
    end
  end

  def self._record!(activity, project_member, issue)
    record_with_detail!(project_member, "issues.#{activity}") do |pa|
      pa.build_issue(issue_id: issue.id, title: issue.title)
    end
  end

  def present_target(presenter)
    return presenter.present_as_text(title) if deleted?
    presenter.present_as_link(title) { |p| p.project_issue_url(project_id: project_id, id: issue_id) }
  end

  private

    def deleted?
      project_activity.activity == 'issues.deleted'.freeze
    end
end
