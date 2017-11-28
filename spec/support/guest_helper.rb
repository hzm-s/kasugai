require 'securerandom'

module GuestHelper
  module MockMail
    def self.deliver_later!
    end
  end

  module MockMailer
    def self.sign_in(*args)
      MockMail
    end

    def self.sign_up(*args)
      MockMail
    end
  end

  module Common
    def sign_up(attrs = nil)
      form = SignUpForm.new(attrs || generate_sign_up_attributes)

      service = GuestService.new(mailer: MockMailer)
      token = service.start_sign_up(form).token

      service.sign_up(token).user
    end

    def generate_sign_up_attributes
      name_chunks = ['User', SecureRandom.hex(8)]
      {
        name: name_chunks.join(' '),
        email: "#{name_chunks.join('.')}@example.com"
      }
    end

    def get_sign_in_token(email)
      GuestService.start_sign_in_by_email(email).token
    end
  end

  module Feature
    def sign_in(user)
      token = get_sign_in_token(user.email)
      visit sign_in_path(token)
    end
  end

  module Controller
    include UserHelper

    def reset_session(*args); end
  end

  module Request
    def sign_in(user)
      token = get_sign_in_token(user.email)
      get sign_in_path(token)
    end
  end
end

RSpec.configure do |c|
  c.include GuestHelper::Common
  c.include GuestHelper::Feature, type: :feature
  c.include GuestHelper::Feature, type: :system
  c.include GuestHelper::Request, type: :request
  c.include GuestHelper::Controller, type: :controller
end
