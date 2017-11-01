class SignUp < ApplicationRecord
  has_secure_token

  def continue
    User.new(name: name) do |u|
      u.build_email_sign_in(email: email)
      u.save
    end
  end
end
