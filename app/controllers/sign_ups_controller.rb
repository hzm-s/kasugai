class SignUpsController < ApplicationController
  include GuestHandler

  def new
    @form = SignUpForm.new
  end

  def create
    form = SignUpForm.new(form_params)
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
      params.require(:form).permit(:name, :email)
    end
end
