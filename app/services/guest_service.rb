class GuestService < ApplicationService

  def initialize(mailer: GuestMailer)
    @mailer = mailer
  end

  def accept(params)
    if user = User.find_by_email(params.email)
      start_sign_in(params)
    else
      start_sign_up(params)
    end
  end

  def start_sign_in(params)
    return failure(params: params) unless params.valid?

    sign_in = SignIn.create!(email: params.email)
    @mailer.sign_in(sign_in).deliver_later!
    success(sign_up?: false)
  end

  def start_sign_up(params)
    return failure(params: params) unless params.valid?

    sign_up = SignUp.create!(name: params.name, email: params.email)
    @mailer.sign_up(sign_up).deliver_later!
    success(sign_up?: true, token: sign_up.token)
  end

  def sign_up(token)
    sign_up = SignUp.find_available(token)
    return failure unless sign_up

    user = sign_up.complete
    success(user: user)
  end

  def sign_in(token)
    sign_in = SignIn.find_available(token)
    return failure unless sign_in

    user = sign_in.authenticate
    success(user: user)
  end
end
