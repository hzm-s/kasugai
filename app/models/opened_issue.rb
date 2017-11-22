class OpenedIssue < ApplicationRecord
  include RankedModel

  ranks :priority_order, with_same: :project_id

  class << self

    def add!(issue)
      create!(project_id: issue.project_id, issue_id: issue.id)
    end
  end
end
