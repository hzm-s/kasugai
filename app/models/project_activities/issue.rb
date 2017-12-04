class ProjectActivities::Issue < ApplicationRecord
  belongs_to :project_activity

  delegate :project_id, to: :project_activity

  def self.record!(activity, project_member, issue)
    ProjectActivity.new(
      project_id: project_member.project_id,
      user_id: project_member.user_id,
      activity: "issues.#{activity}"
    ) do |pa|
      pa.build_issue(issue_id: issue.id, title: issue.title)
      pa.save!
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
