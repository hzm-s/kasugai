DailyActivities = Struct.new(:date, :activities) do

  def self.group_by_project(date, activities)
    lists =
      activities
        .group_by { |e| e.project_id }
        .map { |project_id, subset| ProjectActivityList.new(project_id, subset) }
    new(date, lists)
  end
end
