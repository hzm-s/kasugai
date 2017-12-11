require 'rails_helper'

describe 'ブックマークした課題リスト' do
  context do
    include_context '2人のユーザーがそれぞれプロジェクトを作成している'

    it do
      issue_a = create_issue(member_a, title: 'AAA')
      issue_b = create_issue(member_a, title: 'BBB')
      issue_c = create_issue(member_a, title: 'CCC')

      bookmark_issue(member_a, issue_a)
      bookmark_issue(member_a, issue_b)

      IssueService.change_priority(issue_c, 0)
      IssueService.change_priority(issue_a, 2)

      bookmark_issue(member_a, issue_c)

      sign_in(user_a)
      visit project_path(project_a)
      issues = all('.app_issue_title').map(&:text)
      expect(issues).to eq([issue_c.title, issue_b.title, issue_a.title])
    end

    it do
      issue_a = create_issue(member_a, title: '課題A')
      issue_b = create_issue(member_b, title: '課題B')

      bookmark_issue(member_a, issue_a)
      bookmark_issue(member_b, issue_b)

      aggregate_failures do
        sign_in(user_a)
        visit project_path(project_a)
        expect(page).to have_content(issue_a.title)
        expect(page).to_not have_content(issue_b.title)
      end
    end
  end
end
