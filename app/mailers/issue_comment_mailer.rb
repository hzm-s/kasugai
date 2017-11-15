class IssueCommentMailer < ApplicationMailer

  def posted(recipient, comment)
    @recipient_name = recipient.name
    @issue = comment.issue
    @author_name = comment.author_name
    mail(to: recipient.email, subject: t('.subject', issue_title: @issue.title))
  end
end
