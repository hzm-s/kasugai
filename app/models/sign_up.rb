class SignUp < ApplicationRecord
  has_secure_token

  def complete
    User.new(name: name) do |u|
      u.build_credential(email: email)
      u.save!
    end
  end
end
