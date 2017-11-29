class IssueComment < ApplicationRecord
  belongs_to :issue
  belongs_to :author, class_name: 'User', foreign_key: :user_id

  delegate :name, to: :author, prefix: true
  delegate :initials, to: :author, prefix: true

  def author_id
    user_id
  end

  def observers
    issue.participants(author_project_member)
  end

  def author_project_member
    author.as_member_of(issue.project)
  end
end
