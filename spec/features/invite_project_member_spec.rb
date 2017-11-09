require 'rails_helper'

describe 'プロジェクトメンバーの招待' do
  let(:user) { sign_up }
  let(:project) { create_project(user, name: 'Project') }

  context '未ログインの場合' do
    it do
      name = 'Client Name'
      email ='client@example.com'

      visit new_project_member_path(project)

      click_on 'アカウントを作成する'

      fill_in 'form[name]', with: name
      fill_in 'form[email]', with: email
      perform_enqueued_jobs do
        click_on '続ける'
      end
      open_email(email)
      current_email.click_link 'アカウントを作成する'

      click_on 'プロジェクトに参加する'

      aggregate_failures do
        expect(page).to have_content('プロジェクトに参加しました')
        members = all('.app_member').map {|e| e['data-user-name'] }
        expect(members).to include(name)
      end
    end
  end

  context 'ログイン済みの場合' do
    let(:invited_user) { sign_up }

    it do
      sign_in(invited_user)

      visit new_project_member_path(project)
      click_on 'プロジェクトに参加する'

      aggregate_failures do
        expect(page).to have_content('プロジェクトに参加しました')
        members = all('.app_member').map {|e| e['data-user-name'] }
        expect(members).to include(invited_user.name)
      end
    end
  end
end
