class IssueAppearance < ApplicationRecord
  belongs_to :issue
  belongs_to :project_member

  before_create do
    self.class.where(issue: issue, project_member: project_member).destroy_all
  end
end
