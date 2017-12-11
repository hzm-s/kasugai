class ClosedIssueList < ApplicationRecord
  belongs_to :project
  has_many :closed_issues, dependent: :destroy
  has_many :issues, through: :closed_issues

  def count
    closed_issues.count
  end

  def add(issue)
    self.closed_issues.build(issue: issue)
  end
end
