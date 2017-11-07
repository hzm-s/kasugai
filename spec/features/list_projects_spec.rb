require 'rails_helper'

describe 'プロジェクト一覧' do
  context do
    include_context '2人のユーザーがそれぞれプロジェクトを作成している'

    it do
      sign_in(user_a)
      visit projects_path

      aggregate_failures do
        expect(first('.app-project-name').text).to eq(project_a.name)
        expect(page).to_not have_content(project_b.name)

        members = all('.app-member').map {|e| e['data-user-name'] }
        expect(members).to match_array([user_a.name])
        expect(page).to_not have_content(user_b.name)
      end
    end
  end
end
