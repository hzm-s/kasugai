require 'rails_helper'

describe 'プロジェクトの編集' do
  it do
    user = sign_up
    project = create_project(user, name: 'Project Name Old', description: 'Description Old')

    sign_in(user)
    visit edit_project_path(project)

    fill_in 'form[name]', with: 'Project Name New'
    fill_in 'form[description]', with: 'Description New'
    click_on '保存する'

    aggregate_failures do
      expect(page).to have_content('プロジェクトを更新しました')
      expect(find('#app_project_name').value).to have_content('Project Name New')
      expect(find('#app_project_description').value).to have_content('Description New')
    end
  end
end
