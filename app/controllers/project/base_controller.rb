class Project::BaseController < ApplicationController
  helper_method :current_project

  private

    def current_project
      @current_project ||= fetch_project
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

    def fetch_project
      project_id = params[:project_id] || params[:id]
      Project.find_by(id: project_id)
    end
end
