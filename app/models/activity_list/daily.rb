module ActivityList
  class Daily < Struct.new(:index, :date, :activities)
    include Enumerable

    class << self

      def group_by_project(index, date, activities)
        lists =
          activities
            .group_by { |e| e.project }
            .map { |project, subset| ActivityList::Project.new(index, project, subset) }
        new(index, date, lists)
      end
    end

    def each(&block)
      activities.each(&block)
    end

    def persisted?
      false
    end
  end
end
