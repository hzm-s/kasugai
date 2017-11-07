require 'rails_helper'

describe 'プロジェクトホーム' do
  let(:user) { sign_up }
  let(:name) { 'Project A' }
  let(:description) { 'The project for A' }
  let(:project) { create_project(user, name: name, description: description) }

  before do
    sign_in(user)
  end

  it do
    visit project_path(project)
    aggregate_failures do
      expect(find('#app_project_name')).to have_content(name)
      expect(find('#app_project_description')).to have_content(description)
    end
  end

  it do
    visit project_path('not_exists')
    expect(page).to have_content('あなたのプロジェクト')
  end
end
