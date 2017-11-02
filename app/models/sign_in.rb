class SignIn < ApplicationRecord
  has_secure_token

  def authenticate
    User.find_by_email(email)
  end
end
