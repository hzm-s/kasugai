DailyActivities = Struct.new(:date, :activities) do

  def self.group_by_project(date, activities)
    lists =
      activities
        .group_by { |e| e.project }
        .map { |project, subset| ProjectActivityList.new(project, subset) }
    new(date, lists)
  end
end
