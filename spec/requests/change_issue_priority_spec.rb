require 'rails_helper'

describe '課題の優先順位変更' do
  it do
    user = sign_up
    project = create_project(user, name: 'Project')
    issue = create_issue(user.as_member_of(project), title: 'Issue')

    sign_in(user)

    patch issue_priority_path(issue),
      xhr: true,
      params: { new_position: 0, format: :json }

    aggregate_failures do
      expect(response).to have_http_status(:ok)
      expect(issue.priority_order).to_not be_nil
    end
  end
end
