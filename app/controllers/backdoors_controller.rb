class BackdoorsController < ApplicationController
  layout 'public'

  Backdoor = Struct.new(:user, :sign_in) do
    def user_name
      user.name
    end

    def sign_in_token
      sign_in.token
    end
  end

  def index
    guest_service = GuestService.new
    @backdoors =
      User.all.map do |user|
        Backdoor.new(user, guest_service.start_sign_in_by_email(user.email))
      end
  end
end
