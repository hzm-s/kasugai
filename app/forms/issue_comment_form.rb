class IssueCommentForm
  include ActiveModel::Model

  attr_accessor :content

  validates :content,
    presence: true,
    length: { maximum: 10_000 }
end
