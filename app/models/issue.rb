class Issue < ApplicationRecord
  include RankedModel

  ranks :priority_order, with_same: :project_id

  belongs_to :project
  belongs_to :author, class_name: 'User', foreign_key: :user_id

  has_many :comments, -> { order(:id) }, class_name: 'IssueComment', foreign_key: :issue_id, dependent: :destroy
  has_one :bookmarked, dependent: :destroy, class_name: 'BookmarkedIssue'
  has_one :closed, dependent: :destroy, class_name: 'ClosedIssue'

  delegate :name, to: :author, prefix: true
  delegate :initials, to: :author, prefix: true
  delegate :id, to: :closed, prefix: true

  class << self

    def for_project(project_id)
      left_outer_joins(:closed)
        .where(closed_issues: { id: nil })
        .where(project_id: project_id)
        .order(:priority_order, :created_at)
    end

    def bookmarked(project_id)
      includes(:bookmarked)
        .merge(for_project(project_id))
        .where.not(bookmarked_issues: { id: nil })
    end
  end

  def change_priority_to(new_position)
    update(priority_order_position: new_position)
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

  def close
    create_closed!
  end

  def closed?
    closed.present?
  end

  def reopen
    closed.destroy!
  end
end
