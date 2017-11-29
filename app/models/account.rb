class Account < ApplicationRecord
  has_many :issue_appearances, dependent: :destroy
end
