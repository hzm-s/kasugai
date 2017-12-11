require 'rails_helper'

describe '課題の削除' do
  let(:user) { sign_up }
  let(:project) { create_project(user, name: 'ABC') }
  let(:issue) { create_issue(user.as_member_of(project), title: '課題xyz') }

  before do
    issue
    sign_in(user)
  end

  it do
    visit project_issues_path(project)
    within("#app_issue_#{issue.id}") do
      click_on '削除する'
    end

    aggregate_failures do
      expect(page).to have_content('課題を削除しました')
      expect(page).to_not have_content(issue.title)

      within_last_activity do |link|
        expect(page).to have_content(user.name)
        expect(page).to have_content('課題を削除しました')
        expect(page).to have_content(issue.title)
        expect(link).to be_nil
      end
    end
  end

  it do
    visit project_issue_path(project, issue)
    click_on 'この課題を削除する'

    aggregate_failures do
      expect(page).to have_content('課題を削除しました')
      expect(page).to_not have_content(issue.title)
    end
  end

  context '解決した課題' do
    before do
      close_issue(user.as_member_of(project), issue)
    end

    it do
      visit project_closed_issues_path(project)
      within("#app_issue_#{issue.id}") do
        click_on '削除する'
      end

      aggregate_failures do
        expect(page).to have_content('課題を削除しました')

        visit project_closed_issues_path(project)
        expect(page).to_not have_content(issue.title)
      end
    end
  end
end
