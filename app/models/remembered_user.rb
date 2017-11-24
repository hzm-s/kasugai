class RememberedUser < ApplicationRecord
  belongs_to :user

  class << self

    def find_user(user_id)
      includes(:user)
        .find_by(user_id: user_id)
        &.user
    end

    def add(user_id)
      transaction do
        where(user_id: user_id).destroy_all
        create!(user_id: user_id)
      end
    end

    def delete(user_id)
      find_by(user_id: user_id)&.destroy!
    end
  end
end
