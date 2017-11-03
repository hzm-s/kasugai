require 'rails_helper'

describe 'Find SignUp' do
  describe '.find_available' do
    it 'メールアドレス1つにつき1つのレコード' do
      sign_up_a1 = SignUp.create!(name: 'name a', email: 'a@example.com')
      sign_up_a2 = SignUp.create!(name: 'name a', email: 'a@example.com')
      sign_up_b = SignUp.create!(name: 'name b', email: 'b@example.com')

      aggregate_failures do
        expect(SignUp.find_available(sign_up_a1.token)).to be_nil
        expect(SignUp.find_available(sign_up_a2.token)).to_not be_nil
        expect(SignUp.find_available(sign_up_b.token)).to_not be_nil
      end
    end

    it '15分00秒経過は有効' do
      now = Time.current
      sign_up = nil
      Timecop.travel(now) do
        sign_up = SignUp.create!(name: 'name', email: 'email')
      end
      Timecop.travel(now + 15.minutes) do
        expect(SignUp.find_available(sign_up.token)).to_not be_nil
      end
    end

    it '15分01秒経過は無効' do
      now = Time.current
      sign_up = nil
      Timecop.travel(now) do
        sign_up = SignUp.create!(name: 'name', email: 'email')
      end
      Timecop.travel(now + 15.minutes + 1.second) do
        expect(SignUp.find_available(sign_up.token)).to be_nil
      end
    end

    it 'トークンが違う' do
      sign_up = SignUp.create!(name: 'name', email: 'email')
      expect(SignUp.find_available("#{sign_up.token}x")).to be_nil
    end
  end
end
