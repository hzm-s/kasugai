class ClosedIssueList < ApplicationRecord
  belongs_to :project
  has_many :closed_issues

  def count
    closed_issues.count
  end
end
