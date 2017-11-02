require 'rails_helper'

describe 'Find SignUp' do
  describe '.find_available' do
    it do
      sign_up_a1 = SignUp.create!(name: 'name a', email: 'a@example.com')
      sign_up_a2 = SignUp.create!(name: 'name a', email: 'a@example.com')
      sign_up_b = SignUp.create!(name: 'name b', email: 'b@example.com')

      aggregate_failures do
        expect(SignUp.find_available(sign_up_a1.token)).to be_nil
        expect(SignUp.find_available(sign_up_a2.token)).to_not be_nil
        expect(SignUp.find_available(sign_up_b.token)).to_not be_nil
      end
    end
  end
end
