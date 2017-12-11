class ClosedIssueList < ApplicationRecord
  belongs_to :project
  has_many :closed_issues, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :issues, through: :closed_issues

  def count
    closed_issues.count
  end

  def add(issue)
    self.closed_issues.build(issue: issue)
  end

  def remove!(issue)
    find_item(issue.id).destroy!
  end

  private

    def find_item(issue_id)
      closed_issues.find_by(issue_id: issue_id)
    end
end
