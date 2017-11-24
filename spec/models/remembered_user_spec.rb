require 'rails_helper'

RSpec.describe RememberedUser, type: :model do
  describe '.sweep' do
    let(:user) { sign_up }

    it do
      now = Time.current
      Timecop.freeze(Time.zone.parse('2017-01-01 00:00:00')) do
        RememberedUser.add(user.id)
      end
      Timecop.freeze(Time.zone.parse('2017-01-15 00:00:01')) do
        expect { RememberedUser.sweep }.to change { RememberedUser.count }.by(-1)
      end
    end

    it do
      now = Time.current
      Timecop.freeze(Time.zone.parse('2017-01-01 00:00:00')) do
        RememberedUser.add(user.id)
      end
      Timecop.freeze(Time.zone.parse('2017-01-15 00:00:00')) do
        expect { RememberedUser.sweep }.to change { RememberedUser.count }.by(0)
      end
    end
  end
end
