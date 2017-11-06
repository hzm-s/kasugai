require 'rails_helper'

describe 'プロジェクトホーム' do
  let(:user) { sign_up }
  let(:name) { 'Project A' }
  let(:description) { 'The project for A' }
  let(:project) { create_project(user, name: name, description: description) }

  before do
    sign_in(user)
    visit project_path(project)
  end

  it do
    aggregate_failures do
      expect(find('#app-project-name')).to have_content(name)
      expect(find('#app-project-description')).to have_content(description)
    end
  end
end
