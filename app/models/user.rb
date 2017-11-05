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
end
