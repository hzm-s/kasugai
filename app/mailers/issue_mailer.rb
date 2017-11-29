class IssueMailer < ApplicationMailer

  def created(recipient, issue)
    @recipient_name = recipient.name
    @issue = issue
    @author_name = issue.author_name
    mail(to: recipient.email, subject: t('.subject', project: issue.project_name))
  end
end
