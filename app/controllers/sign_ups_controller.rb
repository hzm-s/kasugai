class SignUpsController < ApplicationController

  def new
    @form = SignUpForm.new
  end

  def create
    @form = SignUpForm.new(form_params)
    if @form.valid?
      sign_up_or_sign_in(@form)
    else
      render :new
    end
  end

  def verify
    sign_up = SignUp.find_by(token: params[:token])
    user = sign_up.complete
    sign_in(user)
    redirect_to home_url
  end

  private

    def sign_up_or_sign_in(form)
      if user = User.find_by_email(form.email)
        sign_in = SignIn.create!(email: form.email)
        GuestMailer.sign_in(sign_in).deliver_later
        render :create_for_sign_in
      else
        sign_up = SignUp.create!(name: form.name, email: form.email)
        GuestMailer.sign_up(sign_up).deliver_later
        render :create_for_sign_up
      end
    end

    def form_params
      params.require(:form).permit(:name, :email)
    end
end
