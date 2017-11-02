class SignUpsController < ApplicationController

  def new
    @form = SignUpForm.new
  end

  def create
    form = SignUpForm.new(form_params)
    result = GuestService.accept(form)
    if result.succeeded?
      render_created(result)
    else
      @form = result.params
      render :new
    end
  end

  def verify
    result = GuestService.sign_up(params[:token])
    if result.succeeded?
      sign_in(result.user)
      redirect_to home_url
    else
      render :verify_error
    end
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
