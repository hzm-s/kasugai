class ProjectForm
  include ActiveModel::Model

  attr_accessor :name, :description

  validates :name,
    presence: true,
    length: { maximum: 50 }

  validates :description,
    length: { maximum: 100 }

  class << self

    def fill(project)
      new(
        name: project.name,
        description: project.description
      )
    end
  end
end
