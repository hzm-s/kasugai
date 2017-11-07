require 'rails_helper'

describe Issue do
  context do
    include_context '2人のユーザーがそれぞれプロジェクトを作成している'

    it do
      issue_a = IssueService.create(user_a, project_a, IssueForm.new(title: 'A')).issue
      issue_b = IssueService.create(user_b, project_b, IssueForm.new(title: 'B')).issue

      aggregate_failures do
        expect(described_class.for_project(project_a.id)).to eq([issue_a])
        expect(described_class.for_project(project_b.id)).to eq([issue_b])
      end
    end
  end
end
