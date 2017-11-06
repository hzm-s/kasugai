require 'rails_helper'

describe ProjectForm do
  let(:valid) do
    {
      name: 'name',
      description: 'description'
    }
  end

  it do
    form = described_class.new(valid)
    expect(form).to be_valid
  end

  it do
    form = described_class.new(valid.merge(name: ''))
    expect(form).to_not be_valid
    expect(form.errors[:name]).to include('を入力してください')
  end
end
