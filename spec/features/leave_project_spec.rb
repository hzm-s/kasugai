require 'rails_helper'

describe 'プロジェクトから離脱' do
  let(:user_a) { sign_up }
  let(:user_b) { sign_up }
  let(:project) { create_project(user_a, name: 'P') }
  let(:member) { add_project_member(project, user_b) }

  context 'メンバーが2人以上の場合' do
    before do
      [user_a, user_b, project, member]
    end

    it do
      sign_in(user_b)
      visit project_members_path(project)

      within("#app_project_member_#{member.id}") do
        click_on 'メンバーから外れる'
      end

      aggregate_failures do
        expect(page).to have_content('プロジェクトのメンバーから外れました')

        visit project_path(project)
        expect(current_path).to eq(projects_path)
      end
    end

    it do
      sign_in(user_a)
      visit project_members_path(project)

      within("#app_project_member_#{member.id}") do
        expect(page).to_not have_content('メンバーから外れる')
      end
    end
  end

  context 'メンバーが1人の場合' do
    before do
      [user_a, project]
    end

    it do
      sign_in(user_a)
      visit project_members_path(project)
      expect(page).to_not have_content('メンバーから外れる')
    end
  end
end
