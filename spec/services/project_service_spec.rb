require 'rails_helper'

describe ProjectService do
  let(:user) { sign_up }

  describe '.create' do
    it do
      params = ProjectForm.new(name: 'P')
      expect { described_class.create(user, params) }
        .to change { Project.count }.by(1)
        .and change { ProjectMember.count }.by(1)
        .and change { IssueList.count }.by(1)
        .and change { BookmarkedIssueList.count }.by(1)
        .and change { ClosedIssueList.count }.by(1)
    end
  end

  describe '.delete' do
    let(:project) { create_project(user, name: 'P') }
    let(:issue) { create_issue(user.as_member_of(project), title: 'I') }
    let(:comment) { post_comment(user.as_member_of(project), issue, content: 'C') }

    before do
      user
      project
      issue
      IssueService.bookmark(issue)
      comment
    end

    it do
      described_class.delete(project)

      aggregate_failures do
        expect(Project.find_by(id: project.id)).to be_nil
        expect(ProjectMember.find_by(user_id: user.id, project_id: project.id)).to be_nil
        expect(IssueList.find_by(project_id: project.id)).to be_nil
        expect(ClosedIssueList.find_by(project_id: project.id)).to be_nil
        expect(BookmarkedIssueList.find_by(project_id: project.id)).to be_nil
        expect(Issue.find_by(id: issue.id)).to be_nil
        expect(IssueComment.find_by(id: comment.id)).to be_nil
        expect(User.find_by(id: user.id)).to_not be_nil
      end
    end

    it do
      expect { described_class.delete(project) }
        .to change { Project.count }.by(-1)
        .and change { ProjectMember.count }.by(-1)
        .and change { IssueList.count }.by(-1)
        .and change { ClosedIssueList.count }.by(-1)
        .and change { BookmarkedIssueList.count }.by(-1)
        .and change { Issue.count }.by(-1)
        .and change { IssueComment.count }.by(-1)
        .and change { User.count }.by(0)
    end
  end
end
