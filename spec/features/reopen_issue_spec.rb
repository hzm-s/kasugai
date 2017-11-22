require 'rails_helper'

describe '課題の解決済みを取り消し' do
  it do
    user = sign_up
    project = create_project(user, name: 'P')
    issue = create_issue(user.as_member_of(project), title: 'I')
    close_issue(issue)

    sign_in(user)
    visit project_closed_issue_path(project, issue.id)

    click_on 'この課題の解決を取り消す'

    aggregate_failures do
      expect(page).to have_content('課題の解決を取り消しました')
      expect(page).to_not have_css('#app_closed_issue')
    end
  end
end
