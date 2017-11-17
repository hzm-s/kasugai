class Project < ApplicationRecord
  has_many :members, class_name: 'ProjectMember', dependent: :destroy
  has_many :issues, dependent: :destroy

  class << self

    def for_user(user_id)
      project_ids = joins(:members).where(project_members: { user_id: user_id }).pluck(:id)
      includes(members: :user)
        .where(id: project_ids)
        .order(:created_at)
    end
  end

  def add_member(user_id)
    members.create!(user_id: user_id)
  end

  def members_without(exclude_member)
    members.reject { |member| member == exclude_member }
  end
end
