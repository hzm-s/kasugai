module ProjectActivityDetail
  extend ActiveSupport::Concern

  included do
    belongs_to :project_activity
    delegate :project_id, to: :project_activity
  end

  class_methods do
    def record_with_detail!(project_member, activity, &block)
      ProjectActivity.record_with_detail!(project_member, activity, &block)
    end
  end
end
