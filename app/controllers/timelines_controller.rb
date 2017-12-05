class TimelinesController < ApplicationController
  before_action :ensure_signed_in

  def show
    @dailies = ActivityList::Daily.for_user(current_user.id)
  end
end
