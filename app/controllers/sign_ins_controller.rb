class SignInsController < ApplicationController

  def new
    @form = SignInForm.new
  end

  def create
    form = SignInForm.new(form_params)
    result = GuestService.accept(form)
    if result.succeeded?
      if result.sign_up?
        render template: 'sign_ups/create'
      else
        render
      end
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
