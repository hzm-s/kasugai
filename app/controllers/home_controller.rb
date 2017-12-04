class HomeController < ApplicationController
  before_action :ensure_signed_in

  def show
    redirect_to timeline_url
  end
end
