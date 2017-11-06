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
    fill_in 'form[initials]', with: 'UN'
    fill_in 'form[name]', with: 'New Username'
    click_on '保存する'

    aggregate_failures do
      expect(find('#form_initials').value).to eq('UN')
      expect(find('#form_name').value).to eq('New Username')
    end
  end

  it do
    fill_in 'form[initials]', with: ''
    click_on '保存する'

    expect(page).to have_content('イニシャルを入力してください')
  end
end
