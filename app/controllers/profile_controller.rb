class ProfileController < ApplicationController

  def edit
    @form = EditProfileForm.fill(current_user)
  end
end
