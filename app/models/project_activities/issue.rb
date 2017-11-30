class ProjectActivities::Issue < ApplicationRecord

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

  def link_text
    title
  end

  def link_url
    '#'
  end
end
