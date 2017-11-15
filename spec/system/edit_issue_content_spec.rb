require 'rails_helper'

describe '課題本文の編集' do
  it do
    user = sign_up
    project = create_project(user, name: 'Project')
    issue = create_issue(user, project, title: 'Issue', content: 'Issue Content Old')

    sign_in(user)
    visit project_issue_path(project, issue)
    find('#js-open-issue-content-editor').click
    within('#js-issue-content-editor') do
      fill_in 'form[content]', with: 'Issue Content New'
      click_on '保存する'
    end

    find('#js-open-issue-content-editor')
    expect(find('#app_issue_content').text).to eq('Issue Content New')
  end
end
