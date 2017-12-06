class TimelinesController < ApplicationController
  before_action :ensure_signed_in

  def show
    @daily_list = ActivityList::Project.daily_list_for_user(current_user.id, page)
  end

  private

    def page
      @page ||= params[:page] || 1
    end
end
