class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?

  private

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
