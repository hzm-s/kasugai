require 'rails_helper'

describe '課題のアーカイブ' do
  it do
    user = sign_up
    project = create_project(user, name: 'P')
    issue = create_issue(user.as_member_of(project), title: 'Will archive Issue')

    sign_in(user)
    visit project_issue_path(project, issue)

    click_on 'この課題をアーカイブする'

    aggregate_failures do
      expect(page).to have_content('課題をアーカイブしました')
      expect(page).to_not have_content(issue.title)
    end
  end
end
