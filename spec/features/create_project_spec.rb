require 'rails_helper'

describe 'プロジェクトの作成' do
  let(:user) { sign_up }

  it do
    sign_in(user)

    visit new_project_path
    fill_in 'form[name]', with: 'Project A'
    fill_in 'form[description]', with: 'New project'
    click_on '作成する'

    aggregate_failures do
      expect(page).to have_content('プロジェクトを作成しました')
      expect(page).to have_content('Project A')
      expect(page).to have_content('New project')

      members = all('.app-member').map {|e| e['data-user-name'] }
      expect(members).to match_array([user.name])
    end
  end
end
