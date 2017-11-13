require 'rails_helper'

describe 'コメントの投稿', type: :system do
  it do
    user = sign_up
    project = create_project(user, name: 'Project')
    issue = create_issue(user, project, title: 'Issue')

    sign_in(user)
    visit project_issue_path(project, issue)

    content = 'Comment for issue'

    fill_in 'form[content]', with: content
    click_on '投稿する'

    expect(page).to have_content(content)
  end
end
