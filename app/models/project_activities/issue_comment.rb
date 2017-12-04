class ProjectActivities::IssueComment < ApplicationRecord
  belongs_to :project_activity

  delegate :project_id, to: :project_activity

  def self.record!(activity, project_member, issue)
    ProjectActivity.new(
      project_id: project_member.project_id,
      user_id: project_member.user_id,
      activity: "issue_comments.#{activity}"
    ) do |pa|
      pa.build_issue_comment(issue_id: issue.id, issue_title: issue.title)
      pa.save!
    end
  end

  def present_target(presenter)
    presenter.present_as_link(issue_title) { |p| p.project_issue_url(project_id: project_id, id: issue_id) }
  end
end
