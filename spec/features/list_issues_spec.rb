require 'rails_helper'

describe '課題一覧' do
  context do
    include_context '2人のユーザーがそれぞれプロジェクトを作成している'

    it do
      issue_a = IssueService.create(user_a, project_a, IssueForm.new(title: '課題A')).issue
      issue_b = IssueService.create(user_b, project_b, IssueForm.new(title: '課題B')).issue

      sign_in(user_a)
      visit project_issues_path(project_id: project_a)

      aggregate_failures do
        expect(first('.app-issue-title').text).to eq(issue_a.title)
        expect(page).to_not have_content(issue_b.title)
      end
    end
  end
end
