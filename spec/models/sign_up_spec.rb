require 'rails_helper'

describe SignUp do
  describe '#complete' do
    let(:name) { 'User Name' }
    let(:email) { 'user@example.com' }
    let(:sign_up) { SignUp.create!(name: name, email: email) }

    it do
      expect { sign_up.complete }.to change { User.count }.by(1)
    end

    it do
      sign_up.complete
      user = User.last

      aggregate_failures do
        expect(user.name).to eq(name)
        expect(user.email).to eq(email)
        expect(user.initials).to eq('US')
      end
    end
  end
end
