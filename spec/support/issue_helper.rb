module IssueHelper
  def create_issue(project_member, attrs)
    IssueService.create(project_member, IssueForm.new(attrs)).issue
  end

  def post_comment(project_member, issue, attrs)
    IssueCommentService.post(project_member, issue, IssueCommentForm.new(attrs)).comment
  end

  def close_issue(issue)
    IssueService.close(issue)
  end
end

RSpec.configure do |c|
  c.include IssueHelper
end
