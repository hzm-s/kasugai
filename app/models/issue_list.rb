class IssueList < ApplicationRecord
  belongs_to :project
  has_many :opened_issues, dependent: :destroy
  has_many :issues, through: :opened_issues

  def add(issue)
    self.opened_issues.build(issue: issue)
  end

  def remove!(issue)
    self.opened_issues.find_by(issue_id: issue.id).destroy!
  end
end
