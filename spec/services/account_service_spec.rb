require 'rails_helper'

describe AccountService do
  describe '#delete' do
    it do
      user = sign_up
      other_user = sign_up

      project = create_project(user, name: 'P')
      add_project_member(project, other_user)

      issue = create_issue(user.as_member_of(project), title: 'I')
      comment = post_comment(user.as_member_of(project), issue, content: 'IC')

      account = user.account
      expect { described_class.delete(user) }
        .to change { Account.exists?(account.id) }.from(true).to(false)
        .and change { Account.count }.by(-1)
        .and change { User.count }.by(0)
        .and change { Project.count }.by(0)
        .and change { Issue.count }.by(0)
        .and change { IssueComment.count }.by(0)
    end
  end
end
