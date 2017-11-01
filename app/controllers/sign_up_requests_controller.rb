class SignUpRequestsController < ApplicationController

  def new
    @sign_up_request = SignUpRequest.new
  end

  def create
    if user = User.find_by_email(sign_up_request_params[:email])
      reception = Reception.create_for_sign_in(user.email)
      GuestMailer.sign_in(reception).deliver_later
      render :create_for_sign_in
    else
      reception = Reception.create_for_sign_up(sign_up_request_params)
      GuestMailer.sign_up(reception).deliver_later
      render :create_for_sign_up
    end
  end

  private

    def sign_up_request_params
      params.require(:sign_up_request).permit(:name, :email)
    end
end
