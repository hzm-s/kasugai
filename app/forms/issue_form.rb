class IssueForm
  include ActiveModel::Model

  attr_accessor :title, :content

  validates :title,
    presence: true,
    length: { maximum: 50 }

  validates :content,
    length: { maximum: 10_000, allow_blank: true }
end
