class TimelinesController < ApplicationController

  def show
    @activities = ProjectActivity.dailies_for_user(current_user.id)
  end
end
