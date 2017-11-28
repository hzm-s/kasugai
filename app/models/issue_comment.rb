class IssueComment < ApplicationRecord
  belongs_to :issue
  belongs_to :author, class_name: 'User', foreign_key: :user_id

  delegate :id, to: :author, prefix: true
  delegate :name, to: :author, prefix: true
  delegate :initials, to: :author, prefix: true
end
