class IssueCommentForm
  include ActiveModel::Model

  attr_accessor :content

  validates :content, presence: true
end
