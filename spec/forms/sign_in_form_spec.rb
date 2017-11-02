require 'rails_helper'

describe SignInForm do
  it do
    form = SignInForm.new(email: 'user@example.com')
    expect(form.name).to eq('user@example.com')
  end
end
