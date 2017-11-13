require 'rails_helper'

describe 'プロジェクトメンバー一覧' do
  context do
    include_context '2人のユーザーがそれぞれプロジェクトを作成している'

    let(:user_c) { sign_up }

    it do
      ProjectService.add_member(project_a, user_b.id)
      ProjectService.add_member(project_a, user_c.id)
      ProjectService.add_member(project_b, user_c.id)

      sign_in(user_a)
      visit project_members_path(project_a)

      members = all('.app_member_name').map(&:text)

      expect(members).to match_array([user_a.name, user_b.name, user_c.name])
    end
  end
end
