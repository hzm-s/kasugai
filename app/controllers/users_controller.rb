class UsersController < ApplicationController

  def create
    result = GuestService.sign_up(params[:token])
    if result.succeeded?
      sign_in(result.user)
      redirect_to home_url
    else
      render :error
    end
  end
end
