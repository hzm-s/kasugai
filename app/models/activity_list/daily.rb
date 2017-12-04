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
      @cache_key ||= "#{self.class.to_s.underscore}/#{date.to_s(:number)}_#{activity_count}"
    end

    def today?
      @is_today ||= date.today?
    end

    def persisted?
      false
    end
  end
end
