require 'rails_helper'

describe 'コメントの投稿' do
  let(:user_a) { sign_up }
  let(:user_b) { sign_up }
  let(:user_c) { sign_up }
  let(:user_z) { sign_up }

  let(:project) { create_project(user_a, name: 'Project') }
  let(:other_project) { create_project(user_z, name: 'Other Project') }

  let(:issue) { create_issue(user_a, project, title: 'Issue') }

  before do
    add_project_member(project, user_b)
    add_project_member(project, user_c)

    create_issue(user_z, other_project, title: 'Other Project Issue')
  end

  it do
    sign_in(user_a)

    perform_enqueued_jobs do
      post issue_comments_path(issue),
        xhr: true,
        params: { form: { content: 'Comment for Issue' } }
    end

    aggregate_failures do
      open_email(user_a.email)
      expect(current_email).to be_nil

      open_email(user_b.email)
      expect(current_email).to have_content(issue.title)

      open_email(user_c.email)
      expect(current_email).to have_content(issue.title)

      open_email(user_z.email)
      expect(current_email).to be_nil
    end
  end
end
