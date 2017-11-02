class SignInsController < ApplicationController
  include GuestHandler

  def new
    @form = SignInForm.new
  end

  def create
    form = SignInForm.new(form_params)
    result = GuestService.accept(form)
    if result.succeeded?
      render_success_to_sign_up_or_in(result)
    else
      @form = result.params
      render :new
    end
  end

  private

    def form_params
      params.require(:form).permit(:email)
    end
end
