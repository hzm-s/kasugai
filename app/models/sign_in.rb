class SignIn < ApplicationRecord
  has_secure_token

  class << self

    def find_available(token)
      where(token: token)
        .where('created_at > ?', Time.current - 15.minutes)
        .first
    end
  end

  def authenticate
    User.find_by_email(email)
  end
end
