require "rails_helper"

RSpec.describe IssueCommentMailer, type: :mailer do
  describe '#posted' do
    it do
      author = sign_up
      recipient = sign_up

      project = create_project(author, name: 'P')
      add_project_member(project, recipient)

      issue = create_issue(author, project, title: '課題ABC')
      comment = post_comment(author, issue, content: 'C')

      mail = described_class.posted(recipient, comment)

      aggregate_failures do
        expect(mail.to).to match_array([recipient.email])
        expect(mail.subject).to include(issue.title)
        expect(mail.body).to include("#{recipient.name}さん")
        expect(mail.body).to include(issue.title)
        expect(mail.body).to include(project_issue_path(project, issue))
      end
    end
  end
end
