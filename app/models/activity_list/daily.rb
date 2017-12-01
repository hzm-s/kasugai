module ActivityList
  class Daily < Struct.new(:date, :activities)
    include Enumerable

    class << self

      def group_by_project(date, activities)
        lists =
          activities
            .group_by { |e| e.project }
            .map { |project, subset| ActivityList::Project.new(project, subset) }
        new(date, lists)
      end
    end

    def each(&block)
      activities.each(&block)
    end
  end
end
