class IssueAppearance < ApplicationRecord
  belongs_to :issue
  belongs_to :project_member
end
