require 'rails_helper'

describe 'コメントの表示' do
  let(:user) { sign_up }
  let(:other_user) { sign_up }

  let(:project) { create_project(user, name: 'Project') }

  let(:issue) { create_issue(user.as_member_of(project), title: 'Issue') }
  let(:comment) { post_comment(user, issue, content: 'Comment for issue') }
  let(:comment2) { post_comment(user, issue, content: 'Comment for issue 2') }
  let(:comment_by_other_user) { post_comment(other_user, issue, content: 'By Other user') }

  before do
    add_project_member(project, other_user)
    comment
    comment2
    comment_by_other_user
  end

  it do
    sign_in(user)
    visit project_issue_path(project, issue)
    find("#app_issue_comment_#{comment.id}")

    aggregate_failures do
      expect(first('.app_issue_comment_content').text).to eq(comment.content)
      expect(first('.app_issue_comment_author').text).to eq(user.name)
      expect(first('.app_issue_comment_created_at').text).to eq(I18n.l(comment.created_at))

      within("#app_issue_comment_#{comment_by_other_user.id}") do
        expect(page).to_not have_link('削除する')
      end
    end
  end

  context do
    include_context '2人のユーザーがそれぞれプロジェクトを作成している'

    it do
      issue_a1 = create_issue(user_a.as_member_of(project_a), title: 'issueA1')
      issue_a2 = create_issue(user_a.as_member_of(project_a), title: 'issueA2')
      issue_b = create_issue(user_b.as_member_of(project_b), title: 'issueB')

      comment_a1 = post_comment(user_a, issue_a1, content: 'Comment for A1')
      comment_a2 = post_comment(user_a, issue_a2, content: 'Comment for A2')
      comment_b = post_comment(user_b, issue_b, content: 'Comment for B')

      sign_in(user_a)
      visit project_issue_path(project_a, issue_a1)
      aggregate_failures do
        expect(page).to have_content(comment_a1.content)
        expect(page).to_not have_content(comment_a2.content)
        expect(page).to_not have_content(comment_b.content)
      end
    end
  end
end
