require 'rails_helper'

describe 'アカウントの削除' do
  let(:user) { sign_up }

  before do
    sign_in(user)
  end

  it do
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

  it do
    project = create_project(user, name: 'Project ABC')
    visit account_path

    aggregate_failures do
      expect(page).to have_content('プロジェクトのメンバーのため削除できません')
      expect(page).to have_content(project.name)
      expect(page).to_not have_content('アカウントを削除する')
    end
  end
end
