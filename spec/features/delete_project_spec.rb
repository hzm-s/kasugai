require 'rails_helper'

describe 'プロジェクトの削除' do
  it do
    user = sign_up
    project = create_project(user, name: 'Project ABC')

    sign_in(user)
    visit edit_project_path(project)

    click_on '削除する'

    aggregate_failures do
      expect(page).to have_content('プロジェクトを削除しました')
      expect(page).to_not have_content('Project ABC')
    end
  end
end
