require 'rails_helper'

describe 'プロジェクトホーム' do
  let(:user) { sign_up }
  let(:project) { create_project(user, name: 'Project A') }

  before do
    sign_in(user)
    visit project_path(project)
  end

  it do
    aggregate_failures do
      expect(find('#app-project-name')).to have_content('Project A')
    end
  end
end
