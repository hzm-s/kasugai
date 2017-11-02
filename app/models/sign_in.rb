class SignIn < ApplicationRecord
  has_secure_token

  before_create :ensure_email_uniqueness

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

  private

    def ensure_email_uniqueness
      self.class.where(email: self.email).destroy_all
    end
end
