require 'rails_helper'

describe SignUpForm do
  it do
    form = described_class.new(name: 'name', email: 'name@example.com')
    expect(form).to be_valid
  end

  it do
    form = described_class.new(name: '', email: 'name@example.com')
    expect(form).to_not be_valid
    expect(form.errors[:name]).to include('入力してください')
  end

  it do
    form = described_class.new(name: 'name', email: '')
    expect(form).to_not be_valid
    expect(form.errors[:email]).to include('入力してください')
  end

  it do
    form = described_class.new(name: 'name', email: 'bad.email')
    expect(form).to_not be_valid
    expect(form.errors[:email]).to include('正しいメールアドレスではありません')
  end
end
