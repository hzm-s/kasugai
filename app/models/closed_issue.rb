class ClosedIssue < ApplicationRecord
  belongs_to :issue

  delegate :title, to: :issue

  class << self

    def for_project(project_id)
      joins(:issue)
        .where(issues: { project_id: project_id })
        .order(created_at: :desc)
    end
  end
end
