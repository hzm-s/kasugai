require 'rails_helper'

describe IssueService do
  let(:user) { sign_up }
  let(:member) { user.as_member_of(project) }
  let(:project) { create_project(user, name: 'P') }

  describe '#create' do
    it do
      params = IssueForm.new(title: 'Issue')

      expect { described_class.create(member, params) }
        .to change { Issue.count }.by(1)
        .and change { OpenedIssue.count }.by(1)
    end
  end

  describe '#close' do
    it do
      issue = create_issue(member, title: 'I')

      expect { described_class.close(issue) }
        .to change { Issue.count }.by(0)
        .and change { OpenedIssue.count }.by(-1)
        .and change { OpenedIssue.find_by(issue_id: issue.id).present? }.from(true).to(false)
        .and change { ClosedIssue.count }.by(1)
        .and change { ClosedIssue.find_by(issue_id: issue.id).present? }.from(false).to(true)
    end
  end

  describe '#reopen' do
    it do
      issue = create_issue(member, title: 'I')
      close_issue(issue)

      expect { described_class.reopen(issue) }
        .to change { Issue.count }.by(0)
        .and change { ClosedIssue.count }.by(-1)
        .and change { ClosedIssue.find_by(issue_id: issue.id).present? }.from(true).to(false)
        .and change { OpenedIssue.count }.by(1)
        .and change { OpenedIssue.find_by(issue_id: issue.id).present? }.from(false).to(true)
    end
  end

  describe '#bookmark' do
    it do
      issue = create_issue(member, title: 'I')

      expect { described_class.bookmark(issue) }
        .to change { BookmarkedIssue.count }.by(1)
        .and change { BookmarkedIssue.find_by(issue_id: issue.id).present? }.from(false).to(true)
    end
  end

  describe '#unbookmark' do
    it do
      issue = create_issue(member, title: 'I')
      described_class.bookmark(issue)

      expect { described_class.unbookmark(issue) }
        .to change { BookmarkedIssue.count }.by(-1)
        .and change { BookmarkedIssue.find_by(issue_id: issue.id).present? }.from(true).to(false)
    end
  end

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
