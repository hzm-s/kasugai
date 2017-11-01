class User < ApplicationRecord
  has_one :registration

  class << self

    def find_by_email(email)
      joins(:registration)
        .where(registrations: { email: email })
        .first
    end
  end
end
