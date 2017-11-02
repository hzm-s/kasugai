class SignInsController < ApplicationController

  def new
    @form = SignInForm.new
  end

  def create
    form = SignInForm.new(form_params)
    result = GuestService.accept(form)
    if result.sign_up?
      render template: 'sign_ups/create_for_sign_up'
    else
      render template: 'sign_ups/create_for_sign_in'
    end
  end

  private

    def form_params
      params.require(:form).permit(:email)
    end
end
