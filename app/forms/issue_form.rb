class IssueForm
  include ActiveModel::Model

  attr_accessor :title, :content, :field

  validates :title,
    presence: true,
    length: { maximum: 50 }

  validates :content,
    length: { maximum: 10_000, allow_blank: true }

  def self.fill(issue)
    new(title: issue.title, content: issue.content)
  end
end
