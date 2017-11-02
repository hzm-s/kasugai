class HandleGuestService < ApplicationService

  def call(params)
    if user = User.find_by_email(params.email)
      SignInService.call(params)
    else
      SignUpService.call(params)
    end
  end
end
