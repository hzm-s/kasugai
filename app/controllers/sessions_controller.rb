class SessionsController < ApplicationController

  def create
    reception = Reception.find_for_sign_in_by_token(params[:token])
    user = reception.authenticate
    session[:user_id] = user.id
    redirect_to home_url
  end
end
