class SignUpService < ApplicationService

  def call(params)
    return failure(params: params) unless params.valid?

    sign_up = SignUp.create!(name: params.name, email: params.email)
    GuestMailer.sign_up(sign_up).deliver_later!
    success(sign_up?: true)
  end
end
