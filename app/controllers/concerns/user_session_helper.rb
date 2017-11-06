module UserSessionHelper
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :signed_in?
  end

  def ensure_signed_in
    unless signed_in?
      redirect_to new_sign_in_url, alert: t('navs.messages.ensure_signed_in')
    end
  end

  def ensure_signed_out
    if signed_in?
      redirect_to home_url, notice: t('navs.messages.already_signed_in')
    end
  end

  def sign_in(user)
    reset_session
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= fetch_user
  end

  def signed_in?
    current_user.present?
  end

  def fetch_user
    User.find_by(id: session[:user_id])
  end
end