class Issue < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: 'User', foreign_key: :user_id

  has_one :opened, class_name: 'OpenedIssue', dependent: :destroy
  has_one :closed, class_name: 'ClosedIssue', dependent: :destroy
  has_one :bookmarked, dependent: :destroy, class_name: 'BookmarkedIssue'

  has_many :comments, -> { order(:id) }, class_name: 'IssueComment', foreign_key: :issue_id, dependent: :destroy

  delegate :name, to: :author, prefix: true
  delegate :initials, to: :author, prefix: true
  delegate :id, to: :closed, prefix: true
  delegate :priority_order, to: :opened

  class << self

    def for_project(project_id)
      joins(:opened)
        .where(project_id: project_id)
        .order('opened_issues.priority_order, issues.created_at')
    end

    def bookmarked(project_id)
      includes(:bookmarked)
        .merge(for_project(project_id))
        .where.not(bookmarked_issues: { id: nil })
    end
  end

  def bookmark
    create_bookmarked!
  end

  def bookmarked?
    bookmarked.present?
  end

  def unbookmark
    bookmarked.destroy!
  end

  def closed?
    closed.present?
  end
end
