class EmailCallbacksController < ApplicationController

  def create
    sign_up = SignUp.find_by(token: params[:token])
    user = sign_up.continue
    session[:user_id] = user.id
    redirect_to home_url
  end
end
