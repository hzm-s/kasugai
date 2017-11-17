class Project::BaseController < ApplicationController
  helper_method :current_project
  helper_method :current_project_member

  private

    def current_project
      @current_project ||= fetch_project
    end

    def current_project_member
      @current_project_member ||= fetch_project_member
    end

    def ensure_project_existence
      unless current_project.present?
        redirect_to projects_url
      end
    end

    def ensure_project_member
      unless current_project.member?(current_user)
        respond_to do |f|
          f.html { redirect_to projects_url }
          f.js { head :forbidden }
        end
      end
    end

    def fetch_project
      project_id = params[:project_id] || params[:id]
      Project.find_by(id: project_id)
    end

    def fetch_project_member
      current_user&.as_member_of(current_project)
    end
end
