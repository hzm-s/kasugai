class User < ApplicationRecord
  has_one :account, dependent: :destroy

  has_many :project_members
  has_many :project_activities

  delegate :email, to: :account

  class << self

    def find_by_email(email)
      includes(:account)
        .where(accounts: { email: email })
        .first
    end
  end

  def initials=(string)
    super(string.to_s[0..1].upcase)
  end

  def as_member_of(project)
    ProjectMember.find_by_user_and_project(id, project.id)
  end

  def can_delete?
    Project.for_user(id).empty?
  end

  def delete_account!
    raise AccountDeletionError unless can_delete?
    account.destroy!
  end
end
