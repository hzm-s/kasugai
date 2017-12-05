class ProjectActivities::Issue < ApplicationRecord
  include ProjectActivityDetail

  def self.record!(activity, project_member, issue)
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
