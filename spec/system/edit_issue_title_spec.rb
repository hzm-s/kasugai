require 'rails_helper'

describe '課題タイトルの編集' do
  it do
    user = sign_up
    project = create_project(user, name: 'Project')
    issue = create_issue(user.as_member_of(project), title: 'Issue Old')

    sign_in(user)
    visit project_issue_path(project, issue)
    find('#js-open-issue-title-editor').click
    fill_in 'form[title]', with: 'Issue New'
    click_on '保存する'

    find('#js-open-issue-title-editor')
    expect(find('#app_issue_title').text).to eq('Issue New')
  end
end
