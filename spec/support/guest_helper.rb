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

  def sign_up(name:, email:)
    service = GuestService.new(mailer: MockMailer)
    form = SignUpForm.new(name: name, email: email)
    token = service.start_sign_up(form).token
    service.sign_up(token)
  end
end

RSpec.configure do |c|
  c.include GuestHelper
end
