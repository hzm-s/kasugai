require 'rails_helper'

describe 'ログアウト' do
  it do
    user = sign_up
    sign_in(user)
    find('#app_sign_out').click

    aggregate_failures do
      expect(page).to have_content('ログアウトしました')
      expect(page).to_not have_content(user.name)
    end
  end
end
