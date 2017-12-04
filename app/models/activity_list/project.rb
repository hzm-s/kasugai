module ActivityList
  class Project < Struct.new(:index, :project, :activities)
    extend ActiveModel::Naming
    include ActiveModel::Conversion

    delegate :name, to: :project

    def id
      "#{index}_#{project.id}"
    end
  end
end
