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
    form = described_class.new(valid.merge(description: ''))
    expect(form).to be_valid
  end

  it do
    form = described_class.new(valid.merge(name: ''))
    expect(form).to_not be_valid
    expect(form.errors[:name]).to include('を入力してください')
  end

  it do
    form = described_class.new(valid.merge(name: 'a' * 51))
    expect(form).to_not be_valid
    expect(form.errors[:name]).to include('は50文字以内で入力してください')
  end

  it do
    form = described_class.new(valid.merge(description: 'd' * 101))
    expect(form).to_not be_valid
    expect(form.errors[:description]).to include('は100文字以内で入力してください')
  end
end
