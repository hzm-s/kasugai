module ActivityList
  class Project < Struct.new(:project, :activities)
    include Enumerable

    def each(&block)
      activities.each(&block)
    end
  end
end
