class BookmarkedIssueService < ApplicationService

  def add(project_member, issue)
    list = project_member.project.bookmarked_issue_list
    transaction do
      list.add(issue).save!
      issue.touch
    end
    IssueUpdatePropagationJob.perform_later(issue)
  end

  def remove(project_member, issue)
    list = project_member.project.bookmarked_issue_list
    transaction do
      list.remove!(issue)
      issue.touch
    end
    IssueUpdatePropagationJob.perform_later(issue)
  end
end
