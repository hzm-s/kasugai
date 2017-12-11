class IssueList < ApplicationRecord
  belongs_to :project
  has_many :opened_issues, -> { rank(:priority_order) }, dependent: :destroy
  has_many :issues, through: :opened_issues

  delegate :any?, to: :opened_issues

  def add(issue)
    self.opened_issues.build(issue: issue)
  end

  def remove!(issue)
    find_item(issue.id).destroy!
  end

  def change_priority_position!(issue, new_position)
    find_item(issue.id).update!(priority_order_position: new_position)
  end

  private

    def find_item(issue_id)
      opened_issues.find_by(issue_id: issue_id)
    end
end
