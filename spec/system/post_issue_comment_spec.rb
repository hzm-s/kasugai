require 'rails_helper'

describe 'コメントの投稿', type: :system do
  let(:user) { sign_up }
  let(:project) { create_project(user, name: 'Project') }
  let(:issue) { create_issue(user.as_member_of(project), title: 'Issue') }

  before do
    sign_in(user)
    visit project_issue_path(project, issue)
  end

  it do
    content = 'Comment for issue'

    fill_in 'form[content]', with: content
    click_on '投稿する'

    expect(page).to have_content(content)

    within_last_activity do |link|
      expect(page).to have_content(user.name)
      expect(page).to have_content("課題へコメントを投稿しました")
      expect(page).to have_content(content)
      expect_link(link, content: issue.title, path: project_issue_path(project, issue))
    end
  end

  it do
    click_on '投稿する'
    expect(page).to have_content('本文を入力してください')
  end
end
