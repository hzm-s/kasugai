class Reception < ApplicationRecord
  has_secure_token

  has_one :sign_up

  delegate :name, to: :sign_up

  class << self

    def create_for_sign_up(params)
      new(email: params[:email]) do |r|
        r.build_sign_up(name: params[:name])
        r.save
      end
    end

    def find_for_sign_up_by_token(token)
      includes(:sign_up).find_by(token: token)
    end
  end

  def commit_sign_up
    sign_up.commit(email)
  end
end
