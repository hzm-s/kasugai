class SignUp < ApplicationRecord

  def commit(email)
    User.new(name: name) do |u|
      u.build_registration(email: email)
      u.save!
    end
  end
end
