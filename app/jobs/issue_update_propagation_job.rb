class IssueUpdatePropagationJob < ApplicationJob
  queue_as :default

  def perform(issue)
    project = issue.project
    lists = [
      project.issue_list,
      project.closed_issue_list,
      project.bookmarked_issue_list
    ]
    lists.each(&:touch)
  end
end
