class TimelinesController < ApplicationController

  def show
    @activities = ProjectActivity.for_user(current_user.id)
  end
end
