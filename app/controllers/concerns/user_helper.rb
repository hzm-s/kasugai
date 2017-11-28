module UserHelper
  extend ActiveSupport::Concern

  include UserSessionHelper
  include UserGuards

  included do
    if respond_to?(:helper_method)
      helper_method :current_user, :signed_in?
    end
  end

  def signed_in?
    current_user.present?
  end

  def sign_in(user)
    reset_session
    remember_user(user)
  end

  def sign_out
    forget_user(current_user)
    @current_user = nil
  end

  def current_user
    @current_user ||= find_remembered_user
  end
end
