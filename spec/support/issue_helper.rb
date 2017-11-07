module IssueHelper
  def create_issue(user, project, attrs)
    IssueService.create(user, project, IssueForm.new(attrs)).issue
  end
end

RSpec.configure do |c|
  c.include IssueHelper
end
