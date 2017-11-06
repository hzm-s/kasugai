require 'rails_helper'

describe Project do
  let(:user_a) { sign_up }
  let(:user_b) { sign_up }

  it do
    user_a_project = ProjectService.create(user_a, CreateProjectForm.new(name: 'A'))
    user_b_project = ProjectService.create(user_b, CreateProjectForm.new(name: 'B'))

    aggregate_failures do
      expect(described_class.for_user(user_a.id)).to eq([user_a_project])
      expect(described_class.for_user(user_b.id)).to eq([user_b_project])
    end
  end
end
