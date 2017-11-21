require 'rails_helper'

describe IssueService do
  it do
    user = sign_up
    project = create_project(user, name: 'P')
    member = user.as_member_of(project)

    issue_a = create_issue(member, title: 'A')
    issue_b = create_issue(member, title: 'B')
    issue_c = create_issue(member, title: 'C')

    close_issue(issue_a)

    described_class.change_priority(issue_b, 1)

    ordered_issues = Issue.for_project(project.id).map(&:title)
    expect(ordered_issues).to eq(%w(C B))
  end
end
