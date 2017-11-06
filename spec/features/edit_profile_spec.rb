require 'rails_helper'

describe 'プロフィールの編集' do
  let(:user) { sign_up(name: name, email: email) }
  let(:name) { 'User Name' }
  let(:email) { 'user@example.com' }

  before do
    sign_in(user)
    visit edit_profile_path
  end

  it do
    aggregate_failures do
      expect(find('#form_initials').value).to eq('US')
      expect(find('#form_name').value).to eq(name)
    end
  end

  it do
    aggregate_failures do
      expect(find('#form_initials').value).to eq('US')
      expect(find('#form_name').value).to eq(name)
    end
  end
end
