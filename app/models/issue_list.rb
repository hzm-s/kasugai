class IssueList < ApplicationRecord
  belongs_to :project
  has_many :opened_issues
  has_many :issues, through: :opened_issues

  def add(issue)
    self.opened_issues.build(issue: issue)
  end
end
