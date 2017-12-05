class ActivityList::Daily < ApplicationRecord
  has_many :project_list, -> { order(updated_at: :desc) },
    class_name: 'ActivityList::Project', foreign_key: :activity_list_daily_id,
    dependent: :destroy

  class << self

    def for_user(user_id)
      project_ids = Project.project_ids_for_user(user_id)
      includes(:project_list)
        .where(activity_list_projects: { project_id: project_ids })
        .order(updated_at: :desc)
    end
  end

  def today?
    @is_today ||= date.today?
  end
end

__END__
module ActivityList
  class Daily < Struct.new(:index, :date, :activities)
    class << self

      def group_by_project(index, date, activities)
        lists =
          activities
            .group_by { |e| e.project }
            .map { |project, subset| ActivityList::Project.new(index, project, subset) }
        new(index, date, lists)
      end
    end

    def cache_key
      @cache_key ||= "#{self.class.to_s.underscore}/#{date.to_s(:number)}"
    end

    def today?
      @is_today ||= date.today?
    end

    def persisted?
      false
    end
  end
end
