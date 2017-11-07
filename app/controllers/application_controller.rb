class ApplicationController < ActionController::Base
  include UserSessionHelper

  protect_from_forgery with: :exception

  private

    def flash_message
      t("flashes.#{controller_path}.#{action_name}")
    end

    def ensure_project_member
      unless current_project.member?(current_user)
        redirect_to projects_url
      end
    end
end
