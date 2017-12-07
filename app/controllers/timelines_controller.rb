class TimelinesController < ApplicationController
  before_action :ensure_signed_in

  def show
    @timeline = Timeline.for_user(current_user.id, page)
  end

  private

    def page
      @page ||= params[:page] || 1
    end
end
