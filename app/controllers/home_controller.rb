class HomeController < ApplicationController
  before_action :ensure_signed_in

  def show
    #redirect_to projects_url
  end
end
