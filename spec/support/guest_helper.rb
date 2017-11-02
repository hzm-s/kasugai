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

  def sign_up(attrs = {})
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
end

RSpec.configure do |c|
  c.include GuestHelper
end
