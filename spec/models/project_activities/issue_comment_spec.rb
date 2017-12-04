require 'rails_helper'

RSpec.describe ProjectActivities::IssueComment, type: :model do
  it do
    user = sign_up
    project = create_project(user, name: 'P')
    member = user.as_member_of(project)

    issue = create_issue(member, title: 'I')
    comment = post_comment(member, issue, content: 'C')
    delete_issue(member, issue)

    activity = described_class.last

    aggregate_failures do
      presenter = spy(:presenter)

      activity.present_target(presenter)
      expect(presenter).to have_received(:present_as_text)

      activity.present_optional_information(presenter)
      expect(presenter).to_not have_received(:add_issue_comment)
    end
  end
end
