module IssueHelper
  def create_issue(project_member, attrs)
    IssueService.create(project_member, IssueForm.new(attrs)).issue
  end

  def close_issue(project_member, issue)
    IssueService.close(project_member, issue)
  end

  def delete_issue(project_member, issue)
    IssueService.delete(project_member, issue)
  end

  def post_comment(project_member, issue, attrs)
    IssueCommentService.post(project_member, issue, IssueCommentForm.new(attrs)).comment
  end

  def delete_comment(comment)
    IssueCommentService.delete(comment)
  end
end

RSpec.configure do |c|
  c.include IssueHelper
end
