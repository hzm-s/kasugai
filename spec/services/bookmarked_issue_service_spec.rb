require 'rails_helper'

describe BookmarkedIssueService do
  let(:user) { sign_up }
  let(:member) { user.as_member_of(project) }
  let(:project) { create_project(user, name: 'P') }

  describe '#add' do
    it do
      issue = create_issue(member, title: 'I')

      expect { described_class.add(member, issue) }
        .to change { BookmarkedIssue.count }.by(1)
        .and change { BookmarkedIssue.find_by(opened_issue_id: issue.opened_id).present? }.from(false).to(true)
    end
  end

  describe '#remove' do
    it do
      issue = create_issue(member, title: 'I')
      described_class.add(member, issue)

      expect { described_class.remove(member, issue) }
        .to change { BookmarkedIssue.count }.by(-1)
        .and change { BookmarkedIssue.find_by(opened_issue_id: issue.opened_id).present? }.from(true).to(false)
        .and change { OpenedIssue.count }.by(0)
        .and change { Issue.count }.by(0)
    end
  end
end
