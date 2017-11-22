require 'rails_helper'

describe IssueService do
  let(:user) { sign_up }
  let(:member) { user.as_member_of(project) }
  let(:project) { create_project(user, name: 'P') }

  describe '#change_priority' do
    it do
      issue_a = create_issue(member, title: 'A')
      issue_b = create_issue(member, title: 'B')
      issue_c = create_issue(member, title: 'C')
      close_issue(issue_a)

      described_class.change_priority(issue_b, 1)
      ordered_issues = Issue.for_project(project.id).map(&:title)
      expect(ordered_issues).to eq(%w(C B))
    end
  end
end
