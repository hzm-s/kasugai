class ProfileController < ApplicationController

  def edit
    @form = EditProfileForm.fill(current_user)
  end

  def update
    form = EditProfileForm.new(form_params)
    result = ProfileService.update(current_user, form)
    if result.succeeded?
      redirect_to edit_profile_url, notice: flash_message
    else
      @form = result.params
      render :edit
    end
  end

  private

    def form_params
      params.require(:form).permit(:initials, :name)
    end
end
