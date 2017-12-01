module ActivityList
  class Project < Struct.new(:index, :project, :activities)
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    include Enumerable

    def id
      "#{index}_#{project.id}"
    end

    def each(&block)
      activities.each(&block)
    end
  end
end
