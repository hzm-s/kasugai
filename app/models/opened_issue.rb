class OpenedIssue < ApplicationRecord
  include RankedModel

  ranks :priority_order, with_same: :issue_list_id

  belongs_to :issue_list
  belongs_to :issue

  class << self

    def add!(issue)
      create!(project_id: issue.project_id, issue_id: issue.id)
    end

    def change_priority_position!(issue, new_position)
      find_by(issue_id: issue.id).update!(priority_order_position: new_position)
    end

    def delete!(issue)
      find_by(issue_id: issue.id).destroy!
    end
  end
end
