require 'rails_helper'

describe AccountService do
  describe '#delete' do
    let(:user) { sign_up }
    let(:other_user) { sign_up }
    let(:project) { create_project(user, name: 'P') }
    let(:issue) { create_issue(user.as_member_of(project), title: 'I') }
    let(:comment) { post_comment(user.as_member_of(project), issue, content: 'IC') }
    let(:issue_appearance) { user.account.issue_appearances.create!(issue: issue) }

    before do
      [user, other_user, project, issue_appearance]
      add_project_member(project, other_user)
    end

    it do
      ProjectService.delete_member(project, user.as_member_of(project))
      account = user.account
      expect { described_class.delete(user) }
        .to change { Account.exists?(account.id) }.from(true).to(false)
        .and change { Account.count }.by(-1)
        .and change { IssueAppearance.exists?(issue_appearance.id) }.from(true).to(false)
        .and change { IssueAppearance.count }.by(-1)
        .and change { User.count }.by(0)
        .and change { Project.count }.by(0)
        .and change { Issue.count }.by(0)
        .and change { IssueComment.count }.by(0)
    end

    it do
      expect { described_class.delete(user) }.to raise_error(AccountDeletionError)
    end
  end
end
