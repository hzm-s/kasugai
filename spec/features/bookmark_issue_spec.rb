require 'rails_helper'

describe '課題のブックマーク', js: true do
  xit do
    user = sign_up
    project = create_project(user, name: 'Project')
    issue_a = create_issue(user, project, title: '課題A')
    issue_b = create_issue(user, project, title: '課題B')
    issue_c = create_issue(user, project, title: '課題C')

    sign_in(user)
  end
end
