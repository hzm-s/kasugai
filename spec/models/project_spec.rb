require 'rails_helper'

RSpec.describe Project, type: :model do
  describe '#delete_member' do
    let(:user_a) { sign_up }
    let(:user_b) { sign_up }
    let(:project) { create_project(user_a, name: 'P') }
    let(:member_a) { user_a.as_member_of(project) }
    let(:member_b) { add_project_member(project, user_b) }

    before do
      member_a
      member_b
    end

    it do
      expect { project.delete_member(member_b) }
        .to change { ProjectMember.count }.by(-1)
        .and change { ProjectMember.exists?(member_b.id) }.from(true).to(false)
        .and change { User.count }.by(0)
        .and change { Account.count }.by(0)
    end

    it do
      project.delete_member(member_b)
      expect { project.delete_member(member_a) }.to raise_error(ProjectMemberDeletionError)
    end
  end
end
