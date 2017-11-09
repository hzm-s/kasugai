class SessionsController < ApplicationController
  layout 'public'

  before_action :ensure_signed_out, only: [:new, :create]
  before_action :ensure_signed_in, only: [:destroy]

  def create
    result = GuestService.sign_in(params[:token])
    if result.succeeded?
      redirect_url = session[:redirect_to_after_sign_in]
      sign_in(result.user)
      redirect_to redirect_url || home_url
    else
      render :error
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_sign_in_url, notice: flash_message
  end
end
