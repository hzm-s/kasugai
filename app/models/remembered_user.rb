class RememberedUser < ApplicationRecord
  belongs_to :user

  has_secure_token

  class << self

    def find_user_by_token(token)
      includes(:user).find_by(token: token)&.user
    end

    def add(user_id)
      create!(user_id: user_id).token
    end

    def delete(user_id)
      find_by(user_id: user_id)&.destroy!
    end
  end
end
