class IssueAppearance < ApplicationRecord
  belongs_to :issue
  belongs_to :account
end
