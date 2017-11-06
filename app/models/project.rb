class Project < ApplicationRecord
  has_many :members, class_name: :ProjectMember
end
