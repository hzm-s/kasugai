require 'rails_helper'

describe '課題のブックマークを削除', type: :system do
  it do
    user = sign_up
    project = create_project(user, name: 'Project')
    issue_a = create_issue(user, project, title: '課題A')
    issue_b = create_issue(user, project, title: '課題B')
    issue_c = create_issue(user, project, title: '課題C')
    IssueService.bookmark(issue_a)
    IssueService.bookmark(issue_b)
    IssueService.bookmark(issue_c)

    sign_in(user)

    aggregate_failures do
      visit project_issues_path(project)
      within("#app_issue_#{issue_c.id}") do
        first('.app_unbookmark').click
        expect(page).to have_css('.iss-Bookmark-off')
      end

      visit project_path(project)
      within("#app_issue_#{issue_a.id}") do
        first('.app_unbookmark').click
        expect(page).to have_css(".iss-Bookmark-off")
      end

      visit project_issue_path(project, issue_b)
      first('.app_unbookmark').click
      find('#app_issue_content')
      expect(page).to have_css(".app_bookmark")
    end
  end
end
