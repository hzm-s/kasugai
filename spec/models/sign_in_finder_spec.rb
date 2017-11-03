require 'rails_helper'

describe 'Find SignIn' do
  describe '.find_available' do
    let(:user_a) { sign_up }
    let(:user_b) { sign_up }

    it 'メールアドレス1つにつき1つのレコード' do
      sign_in_a1 = SignIn.create!(email: user_a.email)
      sign_in_a2 = SignIn.create!(email: user_a.email)
      sign_in_b = SignIn.create!(email: user_b.email)

      aggregate_failures do
        expect(SignIn.find_available(sign_in_a1.token)).to be_nil
        expect(SignIn.find_available(sign_in_a2.token)).to_not be_nil
        expect(SignIn.find_available(sign_in_b.token)).to_not be_nil
      end
    end

    it '15分00秒経過は有効' do
      now = Time.current
      sign_in = nil
      Timecop.travel(now) do
        sign_in = SignIn.create!(email: user_a.email)
      end
      Timecop.travel(now + 15.minutes) do
        expect(SignIn.find_available(sign_in.token)).to_not be_nil
      end
    end

    it '15分01秒経過は無効' do
      now = Time.current
      sign_in = nil
      Timecop.travel(now) do
        sign_in = SignIn.create!(email: user_a.email)
      end
      Timecop.travel(now + 15.minutes + 1.second) do
        expect(SignIn.find_available(sign_in.token)).to be_nil
      end
    end

    it 'トークンが違う' do
      sign_in = SignIn.create!(email: user_a.email)
      expect(SignIn.find_available("#{sign_in.token}x")).to be_nil
    end
  end
end
