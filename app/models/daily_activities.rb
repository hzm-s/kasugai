DailyActivities = Struct.new(:date, :activities) do
  include Enumerable

  class << self

    def group_by_project(date, activities)
      lists =
        activities
          .group_by { |e| e.project }
          .map { |project, subset| ProjectActivityList.new(project, subset) }
      new(date, lists)
    end
  end

  def each(&block)
    activities.each(&block)
  end
end
