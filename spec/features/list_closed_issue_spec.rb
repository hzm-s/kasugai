require 'rails_helper'

describe '解決した課題の一覧' do
  context do
    include_context '2人のユーザーがそれぞれプロジェクトを作成している'

    let(:closed_a1) { create_issue(member_a, title: 'closed for Project A1') }
    let(:closed_a2) { create_issue(member_a, title: 'closed for Project A2') }
    let(:opened_a) { create_issue(member_b, title: 'opened for Project A') }
    let(:closed_b) { create_issue(member_b, title: 'closed for Project B') }

    before do
      Timecop.freeze(Time.zone.parse('2017-01-23')) do
        close_issue(member_a, closed_a1)
      end
      Timecop.freeze(Time.zone.parse('2017-01-25')) do
        close_issue(member_a, closed_a2)
      end
      close_issue(member_b, closed_b)

      sign_in(user_a)
      visit project_closed_issues_path(project_a)
    end

    it do
      aggregate_failures do
        expect(page).to have_content(closed_a1.title)
        expect(page).to have_content(closed_a2.title)
        expect(page).to_not have_content(opened_a.title)
        expect(page).to_not have_content(closed_b.title)
      end
    end

    it do
      click_on closed_a1.title
      expect(page).to have_content('解決済み')
    end

    it do
      issues = all('.app_issue_title').map(&:text)
      expect(issues).to eq([closed_a2.title, closed_a1.title])
    end

    it do
      expect(first('.app_issue_closed_on').text).to eq(I18n.l(closed_a2.created_at.to_date))
    end

    it do
      visit project_issues_path(project_a)
      expect(page).to have_link('2件の解決した課題')
    end
  end
end
