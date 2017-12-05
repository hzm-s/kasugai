class ActivityList::Project < ApplicationRecord
  belongs_to :daily_list, class_name: 'ActivityList::Daily', foreign_key: :activity_list_daily_id
  belongs_to :project, class_name: '::Project', foreign_key: :project_id

  has_many :activities, -> { order(id: :desc) },
    class_name: 'ProjectActivity', foreign_key: :activity_list_project_id,
    dependent: :destroy

  delegate :name, to: :project, prefix: true
end

__END__
module ActivityList
  class Project < Struct.new(:index, :project, :activities)
    extend ActiveModel::Naming
    include ActiveModel::Conversion

    delegate :name, to: :project

    def id
      "#{index}_#{project_id}"
    end

    def cache_key
      "#{self.class.to_s.underscore}/#{project_id}_#{activities.count}"
    end

    private

      def project_id
        @project_id ||= project.id
      end
  end
end
