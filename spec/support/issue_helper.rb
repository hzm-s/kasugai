module IssueHelper
  def create_issue(user, project, attrs)
    IssueService.create(user, project, IssueForm.new(attrs)).issue
  end

  def post_comment(user, issue, attrs)
    IssueCommentService.post(user, issue, IssueCommentForm.new(attrs)).comment
  end
end

RSpec.configure do |c|
  c.include IssueHelper
end
