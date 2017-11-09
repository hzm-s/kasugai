require 'rails_helper'

describe 'プロジェクトメンバーの招待' do
  it do
    user = sign_up
    project = create_project(user, name: 'Project')

    visit new_project_member_path(project)
    click_on 'アカウントを作成する'
    name = 'Client Name'
    email ='client@example.com'
    fill_in 'form[name]', with: name
    fill_in 'form[email]', with: email
    perform_enqueued_jobs do
      click_on '続ける'
    end
    open_email(email)
    current_email.click_link 'アカウントを作成する'

    visit project_path(project)
    members = all('.app_member').map {|e| e['data-user-name'] }
    expect(members).to include(name)
  end
end
