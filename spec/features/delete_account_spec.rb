require 'rails_helper'

describe 'アカウントの削除' do
  it do
    user = sign_up
    other_user = sign_up

    project = create_project(user, name: 'P')
    add_project_member(project, other_user)

    sign_in(user)
    visit account_path
    click_on 'アカウントを削除する'

    aggregate_failures do
      expect(page).to have_content('アカウントを削除しました')

      visit new_sign_in_path
      fill_in 'form[email]', with: user.email
      click_on '続ける'
      expect(page).to have_content('アカウントを作成してください')
    end
  end
end
