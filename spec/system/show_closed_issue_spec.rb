require 'rails_helper'

describe '解決した課題の詳細' do
  it do
    user = sign_up
    project = create_project(user, name: 'P')
    member = user.as_member_of(project)
    issue = create_issue(member, title: 'I')
    post_comment(member, issue, content: 'C')
    close_issue(member, issue)

    sign_in(user)
    visit project_issue_path(project, issue.id)

    aggregate_failures do
      expect(page).to have_content('解決した課題リスト')
      expect(page).to have_content('解決済み')
      expect(page).to have_content('解決を取り消す')
      expect(page).to_not have_content('編集する')
      expect(page).to_not have_content('投稿する')
      expect(page).to_not have_content('この課題を解決にする')
    end
  end
end
