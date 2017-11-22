class ClosedIssue < ApplicationRecord
  belongs_to :issue

  delegate :title, to: :issue

  class << self

    def add!(issue)
      create!(issue_id: issue.id)
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
