class OpenedIssue < ApplicationRecord
  include RankedModel

  ranks :priority_order, with_same: :issue_list_id

  has_one :bookmarked_issue, dependent: :destroy
  belongs_to :issue_list, touch: true
  belongs_to :issue

  def bookmarked?
    bookmarked_issue.present?
  end
end
