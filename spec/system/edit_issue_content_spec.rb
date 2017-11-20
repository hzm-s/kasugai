require 'rails_helper'

describe '課題本文の編集' do
  let(:user) { sign_up }
  let(:project) { create_project(user, name: 'Project') }
  let(:issue) { create_issue(user.as_member_of(project), title: 'Issue', content: 'Issue Content Old') }

  before do
    sign_in(user)
    visit project_issue_path(project, issue)
    find('#js-open-issue-content-editor').click
  end

  it do
    within('#js-issue-content-editor') do
      fill_in 'form[content]', with: 'Issue Content New'
      click_on '保存する'
    end

    find('#js-open-issue-content-editor')
    expect(find('#app_issue_content').text).to eq('Issue Content New')
  end
end
