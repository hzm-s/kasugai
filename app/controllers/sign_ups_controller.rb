class SignUpsController < ApplicationController

  def new
    @form = SignUpForm.new
  end

  def create
    form = SignUpForm.new(form_params)
    result = HandleGuestService.call(form)
    if result.succeeded?
      render_created(result)
    else
      @form = result.params
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

    def render_created(result)
      if result.sign_up?
        render :create_for_sign_up
      else
        render :create_for_sign_in
      end
    end

    def form_params
      params.require(:form).permit(:name, :email)
    end
end
