require 'rails_helper'

describe '課題の解決' do
  it do
    user = sign_up
    project = create_project(user, name: 'P')
    issue = create_issue(user.as_member_of(project), title: 'Will Close Issue')

    sign_in(user)
    visit project_issue_path(project, issue)

    click_on 'この課題を解決済みにする'

    aggregate_failures do
      expect(page).to have_content('課題を解決済みにしました')
      expect(page).to_not have_content(issue.title)

      within_last_activity do |link|
        expect(page).to have_content(user.name)
        expect(page).to have_content('課題を解決済みにしました')
        expect_link(link, content: issue.title, path: project_issue_path(project, issue))
      end
    end
  end
end
