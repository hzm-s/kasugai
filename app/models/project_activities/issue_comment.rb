class ProjectActivities::IssueComment < ApplicationRecord
  include ProjectActivityDetail

  def self.record!(activity, project_member, issue, content)
    record_with_detail!(project_member, "issue_comments.#{activity}") do |pa|
      pa.build_issue_comment(
        issue_id: issue.id,
        issue_title: issue.title,
        content: content[0..200]
      )
    end
  end

  def present_target(presenter)
    return presenter.present_as_text(issue_title) if issue_deleted?
    presenter.present_as_link(issue_title) { |p| p.project_issue_url(project_id: project_id, id: issue_id) }
  end

  def present_optional_information(presenter)
    return if issue_deleted?
    presenter.add_issue_comment(content)
  end

  private

    def issue_deleted?
      @is_issue_deleted ||= ::Issue.find_by(id: issue_id).nil?
    end
end
