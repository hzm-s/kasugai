class Project::MembersController < Project::BaseController

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
end
