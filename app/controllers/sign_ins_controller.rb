class SignInsController < ApplicationController
  layout 'public'

  def new
    @form = SignInForm.new
  end

  def create
    form = SignInForm.new(form_params)
    result = GuestService.start_sign_in(form)
    if result.succeeded?
      render
    else
      render_error(result)
    end
  end

  private

    def form_params
      params.require(:form).permit(:email)
    end

    def render_error(result)
      if result.not_signed_up?
        redirect_to new_sign_up_url, notice: t('sign_ins.new.helps.not_signed_up')
      else
        @form = result.params
        render :new
      end
    end
end
