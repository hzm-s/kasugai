require 'rails_helper'

describe 'アバター背景色の変更' do
  it do
    user = sign_up
    user.update!(theme: 'red')

    sign_in(user)
    visit edit_profile_path
    find('#app_theme_green').click

    expect(page).to have_css('.usr-Avatar-green')
  end
end
