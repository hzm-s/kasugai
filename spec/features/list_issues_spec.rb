require 'rails_helper'

describe '課題一覧' do
  context do
    include_context '2人のユーザーがそれぞれプロジェクトを作成している'

    it do
      issue_a = create_issue(user_a, project_a, title: '課題A')
      issue_b = create_issue(user_b, project_b, title: '課題B')

      sign_in(user_a)
      visit project_issues_path(project_id: project_a)

      aggregate_failures do
        expect(first('.app-issue-title').text).to eq(issue_a.title)
        expect(page).to_not have_content(issue_b.title)
      end
    end
  end
end
