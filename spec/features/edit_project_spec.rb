require 'rails_helper'

describe 'プロジェクトの編集' do
  let(:user) { sign_up }
  let(:project) { create_project(user, name: 'Project Name Old', description: 'Description Old') }

  before do
    sign_in(user)
    visit edit_project_path(project)
  end

  it do
    fill_in 'form[name]', with: 'Project Name New'
    fill_in 'form[description]', with: 'Description New'
    click_on '保存する'

    aggregate_failures do
      expect(page).to have_content('プロジェクトを更新しました')
      expect(find('#app_project_name').value).to have_content('Project Name New')
      expect(find('#app_project_description').value).to have_content('Description New')
    end
  end

  it do
    fill_in 'form[name]', with: ''
    click_on '保存する'
    expect(page).to have_content('プロジェクト名を入力してください')
  end
end
