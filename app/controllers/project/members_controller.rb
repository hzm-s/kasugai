class Project::MembersController < Project::BaseController
  layout 'project'

  before_action :ensure_signed_in, only: [:index, :create, :destroy]
  before_action :ensure_project_member, only: [:index, :destroy]
  before_action :ensure_not_project_member, only: [:new, :create]

  def index
    @members = current_project.members
  end

  def new
    if signed_in?
      render
    else
      session[:redirect_to_after_sign_in] = new_project_member_url(current_project)
      redirect_to new_sign_in_url
    end
  end

  def create
    ProjectService.add_member(current_project, current_user.id)
    redirect_to projects_url, notice: flash_message
  end

  def destroy
    ProjectService.delete_member(current_project_member)
    redirect_to projects_url, notice: flash_message
  end

  private

    def ensure_not_project_member
      if signed_in? && current_user.as_member_of(current_project)
        redirect_to project_url(current_project), notice: flash_message(:already_joined)
      end
    end
end
