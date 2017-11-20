require 'rails_helper'

describe '課題コメントの編集', type: :system do
  let(:user) { sign_up }
  let(:project) { create_project(user, name: 'Project') }
  let(:issue) { create_issue(user.as_member_of(project), title: 'Issue') }
  let(:comment) { post_comment(user.as_member_of(project), issue, content: 'Comment for Issue') }

  before do
    comment
    sign_in(user)
    visit project_issue_path(project, issue)
  end

  it do
    within("#app_issue_comment_#{comment.id}") do
      click_on '編集する'
      fill_in 'form[content]', with: 'Issue Comment New'
      click_on '保存する'
    end
    find('#js-issue-comments')
    expect(page).to have_content('Issue Comment New')
  end

  it do
    within("#app_issue_comment_#{comment.id}") do
      click_on '編集する'
      fill_in 'form[content]', with: ''
      click_on '保存する'
      expect(page).to have_content('入力してください')
    end
  end
end
