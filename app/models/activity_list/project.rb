class ActivityList::Project < ApplicationRecord
  has_many :activities, class_name: 'ProjectActivity', foreign_key: :activity_list_project_id, dependent: :destroy
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
