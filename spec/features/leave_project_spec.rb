require 'rails_helper'

describe 'プロジェクトから離脱' do
  it do
    user_a = sign_up
    user_b = sign_up

    project = create_project(user_a, name: 'P')
    member = add_project_member(project, user_b)

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
end
