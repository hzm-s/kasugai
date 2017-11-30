class TimelinesController < ApplicationController

  def show
    @updates = ProjectUpdate.for_user(current_user.id)
  end
end
