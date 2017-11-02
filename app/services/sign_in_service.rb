class SignInService < ApplicationService

  def call(params)
    sign_in = SignIn.create!(email: params.email)
    GuestMailer.sign_in(sign_in).deliver_later!
    success(sign_up?: false)
  end
end
