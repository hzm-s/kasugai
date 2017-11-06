class Project < ApplicationRecord
  has_many :members, class_name: :ProjectMember, dependent: :destroy

  class << self

    def for_user(user_id)
      includes(:members)
        .where(project_members: { user_id: user_id })
        .order(:created_at)
    end
  end
end
