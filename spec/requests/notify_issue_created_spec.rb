require 'rails_helper'

describe '課題の作成' do
  let(:user_a) { sign_up }
  let(:user_b) { sign_up }
  let(:project) { create_project(user_a, name: 'Project') }

  before do
    add_project_member(project, user_b)
  end

  it do
    sign_in(user_a)

    title = 'New Issue'
    perform_enqueued_jobs do
      post project_issues_path(project),
        params: { form: { title: title } }
    end

    aggregate_failures do
      open_email(user_a.email)
      expect(current_email).to be_nil

      open_email(user_b.email)
      expect(current_email).to have_content(title)
    end
  end
end
