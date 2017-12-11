class OpenedIssue < ApplicationRecord
  include RankedModel

  ranks :priority_order, with_same: :issue_list_id

  belongs_to :issue_list
  belongs_to :issue

  class << self

    def change_priority_position!(issue, new_position)
      find_by(issue_id: issue.id).update!(priority_order_position: new_position)
    end
  end
end
