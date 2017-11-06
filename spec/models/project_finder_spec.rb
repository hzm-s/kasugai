require 'rails_helper'

describe Project do
  let(:user_a) { sign_up }
  let(:user_b) { sign_up }

  it do
    user_a_project = create_project(user_a, name: 'A')
    user_b_project = create_project(user_b, name: 'B')

    aggregate_failures do
      expect(described_class.for_user(user_a.id)).to eq([user_a_project])
      expect(described_class.for_user(user_b.id)).to eq([user_b_project])
    end
  end
end
