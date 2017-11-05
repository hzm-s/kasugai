require 'rails_helper'

describe SignIn do
  describe '.sweep' do
    it do
      now = Time.current
      Timecop.freeze(Time.zone.parse('2017-01-23 00:00:00')) do
        SignIn.create!(email: 'email')
      end
      Timecop.freeze(Time.zone.parse('2017-01-23 00:15:00')) do
        expect { SignIn.sweep }.to change { SignIn.count }.by(0)
      end
    end

    it do
      Timecop.freeze(Time.zone.parse('2017-01-23 00:00:00')) do
        SignIn.create!(email: 'email')
      end
      Timecop.freeze(Time.zone.parse('2017-01-23 00:15:01')) do
        expect { SignIn.sweep }.to change { SignIn.count }.by(-1)
      end
    end
  end
end
