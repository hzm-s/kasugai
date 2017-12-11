class Issue < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: 'User', foreign_key: :user_id

  has_one :opened, class_name: 'OpenedIssue', dependent: :destroy
  has_one :closed, class_name: 'ClosedIssue', dependent: :destroy

  has_many :comments, -> { order(:id) }, class_name: 'IssueComment', foreign_key: :issue_id, dependent: :destroy
  has_many :issue_appearances, -> { includes(:project_member) }, dependent: :destroy

  delegate :bookmarked?, to: :opened

  delegate :id, to: :opened, prefix: true

  delegate :name, to: :author, prefix: true
  delegate :initials, to: :author, prefix: true
  delegate :id, to: :closed, prefix: true
  delegate :name, to: :project, prefix: true

  def closed?
    @is_closed ||= closed.present?
  end

  def participants(actor)
    project.members_without(actor) - issue_appearances.map(&:project_member)
  end

  def author_project_member
    author.as_member_of(project)
  end
end
