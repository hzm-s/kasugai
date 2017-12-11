class IssueList < ApplicationRecord
  belongs_to :project
  has_many :opened_issues
  has_many :issues, through: :opened_issues

  class << self

    def find_by_issue_id(issue_id)
      includes(:opened_issues).find_by(opened_issues: { issue_id: issue_id })
    end
  end

  def add(issue)
    self.opened_issues.build(issue: issue)
  end

  def remove!(issue)
    self.issues.destroy(issue)
  end
end
