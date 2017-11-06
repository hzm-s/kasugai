class ApplicationController < ActionController::Base
  include UserSessionHelper

  protect_from_forgery with: :exception

  private

    def flash_message
      t("flashes.#{controller_name}.#{action_name}")
    end
end
