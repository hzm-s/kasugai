class BookmarkedIssueList < ApplicationRecord
  belongs_to :project
  has_many :bookmarked_issues, dependent: :destroy
  has_many :opened_issues, -> { rank(:priority_order) }, through: :bookmarked_issues
  has_many :issues, through: :opened_issues

  delegate :any?, to: :bookmarked_issues

  def add(issue)
    self.bookmarked_issues.build(opened_issue_id: issue.opened_id)
  end

  def remove!(issue)
    bookmarked_issues.find_by(opened_issue_id: issue.opened_id).destroy!
  end
end
