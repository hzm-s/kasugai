require "rails_helper"

RSpec.describe IssueMailer, type: :mailer do
  describe '#created' do
    it do
      author_user = sign_up
      recipient_user = sign_up

      project = create_project(author_user, name: 'P')

      author = author_user.as_member_of(project)
      recipient = add_project_member(project, recipient_user)

      issue = create_issue(author, title: '課題ABC')

      mail = described_class.created(recipient, issue)

      aggregate_failures do
        expect(mail.to).to match_array([recipient_user.email])
        expect(mail.subject).to include(project.name)
        expect(mail.body).to include("#{recipient_user.name}さん")
        expect(mail.body).to include("#{author_user.name}さん")
        expect(mail.body).to include(issue.title)
        expect(mail.body).to include(project_issue_path(project, issue))
      end
    end
  end
end
