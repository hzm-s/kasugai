class TimelinesController < ApplicationController

  def show
    @dailies = ProjectActivity.dailies_for_user(current_user.id)
  end
end
