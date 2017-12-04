class TimelinesController < ApplicationController
  before_action :ensure_signed_in

  def show
    @dailies = ProjectActivity.dailies_for_user(current_user.id)
  end
end
