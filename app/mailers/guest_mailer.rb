class GuestMailer < ApplicationMailer

  def sign_up(sign_up)
    @name = sign_up.name
    @token = sign_up.token
    mail(to: sign_up.email)
  end
end
