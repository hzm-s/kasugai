class User < ApplicationRecord
  has_one :credential

  delegate :email, to: :credential

  class << self

    def find_by_email(email)
      includes(:credential)
        .where(credentials: { email: email })
        .first
    end
  end
end
