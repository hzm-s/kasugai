require 'rails_helper'

describe 'コメントの表示' do
  it do
    user = sign_up
    project = create_project(user, name: 'Project')
    issue = create_issue(user, project, title: 'Issue')
    comment = post_comment(user, issue, content: 'Comment for issue')

    sign_in(user)
    visit project_issue_path(project, issue)
    find("#app_issue_comment_#{comment.id}")

    aggregate_failures do
      expect(first('.app_issue_comment_content').text).to eq(comment.content)
      expect(first('.app_issue_comment_author').text).to eq(user.name)
      expect(first('.app_issue_comment_created_at').text).to eq(I18n.l(comment.created_at))
    end
  end
end
