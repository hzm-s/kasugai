require "rails_helper"

RSpec.describe GuestMailer, type: :mailer do
  describe '#sign_in' do
    it do
      user = sign_up
      sign_in = GuestService.new.start_sign_in_by_email(user.email)

      mail = described_class.sign_in(sign_in)

      aggregate_failures do
        expect(mail.to).to match_array([user.email])
        expect(mail.subject).to include('ログイン')
        expect(mail.body).to include(sign_in_path(token: sign_in.token))
      end
    end
  end

  describe '#sign_up' do
    it do
      email = 'guest@example.com'
      sign_up = SignUp.create!(name: 'guest', email: email)

      mail = described_class.sign_up(sign_up)

      aggregate_failures do
        expect(mail.to).to match_array([email])
        expect(mail.subject).to include('ようこそ')
        expect(mail.body).to include(verify_sign_up_path(token: sign_up.token))
      end
    end
  end
end
