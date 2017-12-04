class ProjectActivities::IssueComment < ApplicationRecord
  include ProjectActivityDetail

  def self.record!(activity, project_member, issue)
    record_with_detail!(project_member, "issue_comments.#{activity}") do |pa|
      pa.build_issue_comment(issue_id: issue.id, issue_title: issue.title)
    end
  end

  def present_target(presenter)
    presenter.present_as_link(issue_title) { |p| p.project_issue_url(project_id: project_id, id: issue_id) }
  end
end
