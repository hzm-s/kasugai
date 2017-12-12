class ClosedIssue < ApplicationRecord
  belongs_to :closed_issue_list, touch: true
  belongs_to :issue, touch: true

  delegate :title, to: :issue

  class << self

    def add!(issue)
      create!(issue_id: issue.id)
    end

    def delete!(issue)
      find_by(issue_id: issue.id).destroy!
    end

    def for_project(project_id)
      joins(:issue)
        .where(issues: { project_id: project_id })
        .order(created_at: :desc)
    end

    def count_for_project(project_id)
      for_project(project_id).count
    end
  end
end
