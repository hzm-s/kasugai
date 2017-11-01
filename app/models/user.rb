class User < ApplicationRecord
  has_one :registration

  delegate :email, to: :registration

  class << self

    def find_by_email(email)
      includes(:registration)
        .where(registrations: { email: email })
        .first
    end
  end
end
