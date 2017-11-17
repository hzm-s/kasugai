class Profile::ThemeController < ApplicationController
  before_action :ensure_signed_in

  def update
    ProfileService.update_theme(current_user, form_params[:theme])
    redirect_to edit_profile_url, notice: t('flashes.profile.update')
  end

  private

    def form_params
      params.require(:form).permit(:theme)
    end
end
