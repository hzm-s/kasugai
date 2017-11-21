require 'rails_helper'

describe '解決した課題の詳細' do
  it do
    user = sign_up
    project = create_project(user, name: 'P')
    issue = create_issue(user.as_member_of(project), title: 'I')
    close_issue(issue)

    sign_in(user)
    visit project_issue_path(project, issue)

    aggregate_failures do
      expect(page).to_not have_content('この課題を解決にする')
    end
  end
end
