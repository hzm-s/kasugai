class ProjectForm
  include ActiveModel::Model

  attr_accessor :name, :description

  validates :name,
    presence: true
end
