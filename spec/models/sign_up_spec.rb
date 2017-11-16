require 'rails_helper'

describe SignUp do
  describe '#complete' do
    let(:name) { 'User Name' }
    let(:email) { 'user@example.com' }
    let(:sign_up) { SignUp.create!(name: name, email: email) }

    it do
      expect { sign_up.complete }
        .to change { User.count }.by(1)
    end

    it do
      sign_up.complete
      user = User.last

      aggregate_failures do
        expect(user.name).to eq(name)
        expect(user.email).to eq(email)
        expect(user.initials).to eq('US')
        expect(UserTheme.all).to include(user.theme)
      end
    end
  end

  describe '.sweep' do
    it do
      now = Time.current
      Timecop.freeze(Time.zone.parse('2017-01-23 00:00:00')) do
        SignUp.create!(name: 'name', email: 'email')
      end
      Timecop.freeze(Time.zone.parse('2017-01-23 00:15:00')) do
        expect { SignUp.sweep }.to change { SignUp.count }.by(0)
      end
    end

    it do
      Timecop.freeze(Time.zone.parse('2017-01-23 00:00:00')) do
        SignUp.create!(name: 'name', email: 'email')
      end
      Timecop.freeze(Time.zone.parse('2017-01-23 00:15:01')) do
        expect { SignUp.sweep }.to change { SignUp.count }.by(-1)
      end
    end
  end
end
