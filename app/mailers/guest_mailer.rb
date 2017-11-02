class GuestMailer < ApplicationMailer

  def sign_up(reception)
    @name = reception.name
    @token = reception.token
    mail(to: reception.email)
  end

  def sign_in(reception)
    @token = reception.token
    mail(to: reception.email)
  end
end
