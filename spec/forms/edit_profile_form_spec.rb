require 'rails_helper'

describe EditProfileForm do
  let(:valid) do
    {
      initials: 'UN',
      name: 'User Name'
    }
  end

  it do
    form = described_class.new(valid)
    expect(form).to be_valid
  end

  it do
    form = described_class.new(valid.merge(initials: 'un'))
    expect(form).to be_valid
  end

  it do
    form = described_class.new(valid.merge(initials: ''))
    expect(form).to_not be_valid
    expect(form.errors[:initials]).to include('を入力してください')
  end

  it do
    form = described_class.new(valid.merge(initials: 'A'))
    expect(form).to_not be_valid
    expect(form.errors[:initials]).to include('は2文字で入力してください')
  end

  it do
    form = described_class.new(valid.merge(initials: 'ABC'))
    expect(form).to_not be_valid
    expect(form.errors[:initials]).to include('は2文字で入力してください')
  end

  it do
    form = described_class.new(valid.merge(initials: 'ああ'))
    expect(form).to_not be_valid
    expect(form.errors[:initials]).to include('は英字のみ入力できます')
  end
end
