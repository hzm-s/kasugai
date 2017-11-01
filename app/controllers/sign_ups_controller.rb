class SignUpsController < ApplicationController

  def create
    reception = Reception.find_for_sign_up_by_token(params[:token])
    user = reception.commit_sign_up
    session[:user_id] = user.id
    redirect_to home_url
  end
end
