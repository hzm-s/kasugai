class SessionsController < ApplicationController
  layout 'public'

  before_action :ensure_signed_out

  def create
    result = GuestService.sign_in(params[:token])
    if result.succeeded?
      sign_in(result.user)
      redirect_to home_url
    else
      render :error
    end
  end
end
