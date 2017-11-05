class UsersController < ApplicationController

  def create
    result = GuestService.sign_up(params[:token])
    if result.succeeded?
      user = result.user
      sign_in = GuestService.start_sign_in_by_email(user.email)
      redirect_to sign_in_url(token: sign_in.token)
    else
      render :error
    end
  end
end
