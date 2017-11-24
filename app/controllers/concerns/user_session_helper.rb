module UserSessionHelper
  extend ActiveSupport::Concern

  included do
    if respond_to?(:helper_method)
      helper_method :current_user, :signed_in?
    end
  end

  def ensure_signed_in
    unless signed_in?
      respond_to do |f|
        f.html { redirect_to new_sign_in_url, alert: t('navs.messages.ensure_signed_in') }
        f.js { head :forbidden }
      end
    end
  end

  def ensure_signed_out
    if signed_in?
      redirect_to home_url, notice: t('navs.messages.already_signed_in')
    end
  end

  def signed_in?
    current_user.present?
  end

  def sign_in(user)
    reset_session
    cookies.signed[:user_id] = { value: user.id, expires: 30.days.from_now }
  end

  def sign_out
    cookies.delete(:user_id)
    cookies.signed[:user_id] = nil
    @current_user = nil
  end

  def current_user
    return nil if (user_id = cookies.signed[:user_id]).nil?
    @current_user ||= find_user(user_id)
  end

  private

    def find_user(user_id)
      User.find_by(id: user_id)
    end
end
