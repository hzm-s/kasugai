class SignIn < ApplicationRecord
  EXPIRATION = 15.minutes

  has_secure_token

  before_create :ensure_email_uniqueness

  class << self

    def find_available(token)
      where(token: token)
        .where('created_at > ?', EXPIRATION.ago)
        .first
    end

    def sweep
      where('created_at < ?', EXPIRATION.ago)
        .delete_all
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
