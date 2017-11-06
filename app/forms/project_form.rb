class ProjectForm
  include ActiveModel::Model

  attr_accessor :name, :description

  validates :name,
    presence: true,
    length: { maximum: 50 }

  validates :description,
    length: { maximum: 100 }
end
