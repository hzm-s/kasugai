module IssueHelper
  def create_issue(project_member, attrs)
    IssueService.create(project_member, IssueForm.new(attrs)).issue
  end

  def post_comment(user, issue, attrs)
    IssueCommentService.post(user, issue, IssueCommentForm.new(attrs)).comment
  end
end

RSpec.configure do |c|
  c.include IssueHelper
end
