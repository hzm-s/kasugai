class SignUpsController < ApplicationController

  def new
    @form = SignUpForm.new
  end

  def create
    if user = User.find_by_email(form_params[:email])
      sign_in = SignIn.create!(email: form_params[:email])
      GuestMailer.sign_in(sign_in).deliver_later
      render :create_for_sign_in
    else
      sign_up = SignUp.create!(form_params)
      GuestMailer.sign_up(sign_up).deliver_later
      render :create_for_sign_up
    end
  end

  def verify
    sign_up = SignUp.find_by(token: params[:token])
    user = sign_up.complete
    session[:user_id] = user.id
    redirect_to home_url
  end

  private

    def form_params
      params.require(:form).permit(:name, :email)
    end
end
