class Project::BaseController < ApplicationController
  helper_method :current_project

  private

    def current_project
      @current_project ||= Project.find(params[:project_id])
    end

    def ensure_project_existence
      unless current_project.present?
        redirect_to projects_url
      end
    end

    def ensure_project_member
      unless current_project.member?(current_user)
        redirect_to projects_url
      end
    end
end
