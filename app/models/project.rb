class Project < ApplicationRecord
  has_many :members, class_name: 'ProjectMember', dependent: :destroy

  has_many :issues
  has_one :issue_list, dependent: :destroy
  has_one :closed_issue_list, dependent: :destroy
  has_one :bookmarked_issue_list, dependent: :destroy

  has_many :activities, class_name: 'ActivityList::Project', foreign_key: :project_id, dependent: :destroy

  class << self

    def for_user(user_id)
      includes(members: :user)
        .where(id: project_ids_for_user(user_id))
        .order(:created_at)
    end

    def project_ids_for_user(user_id)
      joins(:members).where(project_members: { user_id: user_id }).pluck(:id)
    end
  end

  def add_member(user_id)
    members.create!(user_id: user_id)
  end

  def members_without(exclude_member)
    members.reject { |member| member == exclude_member }
  end

  def can_delete_member?
    members.size >= 2
  end

  def delete_member(member)
    raise ProjectMemberDeletionError unless can_delete_member?
    member.destroy!
  end
end
