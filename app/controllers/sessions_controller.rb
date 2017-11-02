class SessionsController < ApplicationController

  def create
    sign_in = SignIn.find_by_token(params[:token])
    user = sign_in.authenticate
    session[:user_id] = user.id
    redirect_to home_url
  end
end
