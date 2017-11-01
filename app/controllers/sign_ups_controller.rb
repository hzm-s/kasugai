class SignUpsController < ApplicationController

  def new
    @sign_up = SignUp.new
  end

  def create
    if user = User.find_by_email(sign_up_params[:email])
    else
      sign_up = SignUp.new(sign_up_params)
      sign_up.save
      GuestMailer.sign_up(sign_up).deliver_later
      redirect_to ready_sign_up_url
    end
  end

  private

    def sign_up_params
      params.require(:sign_up).permit(:name, :email)
    end
end
