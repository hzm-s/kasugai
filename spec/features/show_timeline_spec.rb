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
    Timecop.travel(Date.parse('2017-01-01')) do
      create_issue(member_a, title: 'I1')
      create_issue(member_a, title: 'I2')
      create_issue(member_a, title: 'I3')
    end
    Timecop.travel(Date.parse('2017-01-02')) do
      create_issue(member_a, title: 'I4')
      create_issue(member_a, title: 'I5')
    end
    Timecop.travel(Date.parse('2017-01-03')) do
      create_issue(member_a, title: 'I6')
      create_issue(member_a, title: 'I7')
      create_issue(member_a, title: 'I8')
    end
    Timecop.travel(Date.parse('2017-01-04')) do
      create_issue(member_a, title: 'I9')
    end

    sign_in(user_a)

    aggregate_failures do
      visit timeline_path
      expect_contents(includes: %w(I9 I8 I7 I6 I5 I4), excludes: %w(I3 I2 I1))

      visit timeline_path(page: 2)
      expect_contents(includes: %w(I3 I2 I1), excludes: %w(I9 I8 I7 I6 I5 I4))
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

  private

    def expect_contents(includes:, excludes:)
      includes.each do |i|
        expect(page).to have_content(i)
      end
      excludes.each do |e|
        expect(page).to_not have_content(e)
      end
    end
end
