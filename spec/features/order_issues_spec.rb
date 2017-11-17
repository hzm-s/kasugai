require 'rails_helper'

describe '課題の優先順位変更' do
  context do
    include_context '2人のユーザーがそれぞれプロジェクトを作成している'

    let(:issue_a) { create_issue(user_a.as_member_of(project_a), title: 'A') }
    let(:issue_b) { create_issue(user_a.as_member_of(project_a), title: 'B') }
    let(:issue_c) { create_issue(user_a.as_member_of(project_a), title: 'C') }

    let(:issue_x) { create_issue(user_b.as_member_of(project_b), title: 'X') }
    let(:issue_y) { create_issue(user_b.as_member_of(project_b), title: 'Y') }
    let(:issue_z) { create_issue(user_b.as_member_of(project_b), title: 'Z') }

    before do
      [issue_a, issue_b, issue_c, issue_x, issue_y, issue_z]
      IssueService.change_priority(issue_z, 0)
      IssueService.change_priority(issue_y, 0)
      IssueService.change_priority(issue_x, 0)
      sign_in(user_a)
    end

    it do
      visit project_issues_path(project_a)
      expect(issue_titles).to eq(%w(A B C))

      IssueService.change_priority(issue_c, 0)
      IssueService.change_priority(issue_a, 2)
      IssueService.change_priority(issue_b, 0)

      visit project_issues_path(project_a)
      expect(issue_titles).to eq(%w(B C A))
    end
  end

  private

    def issue_titles
      all('.app_issue_title').map(&:text)
    end
end
