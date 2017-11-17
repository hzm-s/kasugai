require 'rails_helper'

describe '課題コメントの削除', type: :system do
  let(:user) { sign_up }
  let(:project) { create_project(user, name: 'Project') }
  let(:issue) { create_issue(user.as_member_of(project), title: 'Issue') }
  let(:comment) { post_comment(user, issue, content: 'Comment for Issue') }

  before do
    comment
  end

  it do
    sign_in(user)
    visit project_issue_path(project, issue)
    within("#app_issue_comment_#{comment.id}") do
      page.accept_confirm('コメントを削除してよろしいですか?') do
        click_on '削除する'
      end
    end
    find('#js-issue-comments')
    expect(page).to_not have_content(comment.content)
  end
end
