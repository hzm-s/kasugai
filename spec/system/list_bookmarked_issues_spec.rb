require 'rails_helper'

describe 'ブックマークした課題リスト' do
  context do
    include_context '2人のユーザーがそれぞれプロジェクトを作成している'

    it do
      issue = create_issue(user_a, project_a, title: '課題A')

      sign_in(user_b)
      visit project_path(project_b)
      expect(page).to_not have_content(issue.title)
    end
  end
end