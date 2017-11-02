class SignUp < ApplicationRecord
  has_secure_token

  class << self

    def find_available(token)
      where(token: token)
        .where('created_at >= ?', Time.current - 15.minutes)
        .first
    end
  end

  def complete
    User.new(name: name) do |u|
      u.build_credential(email: email)
      u.save!
    end
  end
end
