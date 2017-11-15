require 'rails_helper'

describe 'プロジェクト一覧' do
  context do
    include_context '2人のユーザーがそれぞれプロジェクトを作成している'

    let(:user_c) { sign_up }

    before do
      add_project_member(project_a, user_c)
    end

    it do
      sign_in(user_a)
      visit projects_path

      aggregate_failures do
        expect(first('.app_project_name').text).to eq(project_a.name)
        expect(page).to_not have_content(project_b.name)

        members = all('.app_member').map {|e| e['data-user-name'] }
        expect(members).to match_array([user_a.name, user_c.name])
        expect(page).to_not have_content(user_b.name)
      end
    end
  end
end
