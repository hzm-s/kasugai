class TimelinesController < ApplicationController
  before_action :ensure_signed_in

  def show
    @daily_list = ActivityList::Daily.for_user(current_user.id)
  end
end
