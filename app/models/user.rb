class User < ApplicationRecord
  has_one :account, dependent: :destroy

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
end
