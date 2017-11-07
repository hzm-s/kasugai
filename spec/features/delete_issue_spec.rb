require 'rails_helper'

describe '課題の削除' do
  let(:user) { sign_up }
  let(:project) { create_project(user, name: 'ABC') }
  let(:issue) { create_issue(user, project, title: '課題xyz') }

  it do
    issue
    sign_in(user)
    visit project_issues_path(project)

    within("#app_issue_#{issue.id}") do
      click_on '削除する'
    end

    aggregate_failures do
      expect(page).to have_content('課題を削除しました')
      expect(page).to_not have_content(issue.title)
    end
  end
end
