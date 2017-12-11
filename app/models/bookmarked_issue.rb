class BookmarkedIssue < ApplicationRecord
  belongs_to :bookmarked_issue_list, touch: true
  belongs_to :opened_issue, touch: true
end
