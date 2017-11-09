class Project < ApplicationRecord
  has_many :members, class_name: 'ProjectMember', dependent: :destroy
  has_many :issues, dependent: :destroy

  class << self

    def for_user(user_id)
      includes(:members)
        .where(project_members: { user_id: user_id })
        .order(:created_at)
    end
  end

  def member?(user)
    members.any? { |member| member.same_user?(user) }
  end

  def add_member(user_id)
    members.create!(user_id: user_id)
  end
end
