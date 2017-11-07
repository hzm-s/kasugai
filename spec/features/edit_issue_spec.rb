require 'rails_helper'

describe '課題の編集' do
  let(:user) { sign_up }
  let(:project) { create_project(user, name: 'ABC') }

  it do
    title_old = '課題old'
    content_old = '課題本文old'
    issue = create_issue(user, project, title: title_old, content: content_old)

    sign_in(user)
    visit edit_project_issue_path(project_id: project, id: issue)

    aggregate_failures do
      expect(find('#app-issue-title').value).to eq(title_old)
      expect(find('#app-issue-content').value).to eq(content_old)
    end
  end
end
