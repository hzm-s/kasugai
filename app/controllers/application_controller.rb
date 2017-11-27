class ApplicationController < ActionController::Base
  include UserHelper

  protect_from_forgery with: :exception

  private

    def flash_message(key = action_name)
      t("flashes.#{controller_path}.#{key}")
    end
end
