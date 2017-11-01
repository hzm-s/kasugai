class User < ApplicationRecord
  has_one :email_sign_in

  class << self

    def find_by_email(email)
      joins(:email_sign_in)
        .where(email_sign_ins: { email: email })
        .first
    end
  end
end
