class IssueForm
  include ActiveModel::Model

  attr_accessor :title, :content, :field, :continue

  validates :title,
    presence: true,
    length: { maximum: 50 }

  validates :content,
    length: { maximum: 10_000, allow_blank: true }

  def self.fill(issue)
    new(title: issue.title, content: issue.content)
  end

  def continue?
    continue == '1'
  end

  def set_continue
    self.continue = '1'
  end
end
