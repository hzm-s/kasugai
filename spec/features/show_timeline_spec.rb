require 'rails_helper'

describe 'タイムラインの表示' do
  let(:user_a) { sign_up }
  let(:user_b) { sign_up }
  let(:user_c) { sign_up }

  let(:project) { create_project(user_a, name: 'ABC Project') }
  let(:other_project) { create_project(user_c, name: 'XZY Project') }

  let(:member_a) { user_a.as_member_of(project) }
  let(:member_b) { add_project_member(project, user_b) }
  let(:member_c) { user_c.as_member_of(other_project) }

  let(:issue) { create_issue(member_a, title: 'Issue1') }

  before do
    member_a
    member_b
    member_c
  end

  it do
    issue

    aggregate_failures do
      sign_in(user_a) do
        visit timeline_path
        expect(page).to have_content(project.name)
        expect(page).to have_content(issue.title)
      end

      sign_in(user_b) do
        visit timeline_path
        expect(page).to have_content(project.name)
        expect(page).to have_content(issue.title)
      end

      sign_in(user_c) do
        visit timeline_path
        expect(page).to_not have_content(project.name)
        expect(page).to_not have_content(issue.title)
      end
    end
  end

  it do
    sign_in(user_a)

    aggregate_failures do
      Timecop.travel(1.day.ago) do
        create_issue(member_a, title: 'old')
      end
      visit timeline_path
      expect(page).to_not have_content('今日')

      create_issue(member_a, title: 'new')
      visit timeline_path
      expect(page).to have_content('今日')
    end
  end
end
