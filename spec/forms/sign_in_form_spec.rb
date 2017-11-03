require 'rails_helper'

describe SignInForm do
  it do
    form = described_class.new(email: 'user@example.com')
    expect(form.name).to eq('user@example.com')
  end

  it do
    form = described_class.new(email: '')
    expect(form).to_not be_valid
    expect(form.errors[:email]).to include('を入力してください')
  end

  it do
    form = described_class.new(email: 'bad.email')
    expect(form).to_not be_valid
    expect(form.errors[:email]).to include('は正しいメールアドレスではありません')
  end
end
