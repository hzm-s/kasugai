require 'rails_helper'

describe '課題タイトルの編集' do
  let(:user) { sign_up }
  let(:project) { create_project(user, name: 'Project') }
  let(:issue) { create_issue(user.as_member_of(project), title: 'Issue Old', content: 'Issue Content') }

  before do
    sign_in(user)
    visit project_issue_path(project, issue)
    find('#js-open-issue-title-editor').click
  end

  it do
    fill_in 'form[title]', with: 'Issue New'
    click_on '保存する'

    find('#js-open-issue-title-editor')
    aggregate_failures do
      expect(find('#app_issue_title').text).to eq('Issue New')
      expect(page).to have_content(issue.content)
    end
  end

  it do
    fill_in 'form[title]', with: ''
    click_on '保存する'

    expect(page).to have_content('入力してください')
  end
end
