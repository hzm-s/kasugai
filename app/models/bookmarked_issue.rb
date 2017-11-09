class BookmarkedIssue < ApplicationRecord
  belongs_to :issue

  delegate :title, to: :issue

  class << self

    def for_project(project_id)
      includes(:issue)
        .merge(Issue.for_project(project_id))
        .where(issues: { project_id: project_id })
    end
  end
end
