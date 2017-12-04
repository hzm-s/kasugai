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

    def persisted?
      false
    end
  end
end
