class OpenedIssue < ApplicationRecord
  include RankedModel

  ranks :priority_order, with_same: :issue_list_id

  belongs_to :issue_list
  belongs_to :issue
end
