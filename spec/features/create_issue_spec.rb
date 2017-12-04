require 'rails_helper'

describe '課題の追加' do
  let(:user) { sign_up }
  let(:project) { create_project(user, name: 'ABC') }

  before do
    sign_in(user)
    visit new_project_issue_path(project_id: project.id)
  end

  it do
    fill_in 'form[title]', with: '課題ABC'
    fill_in 'form[content]', with: '課題本文'
    click_on '作成する'

    aggregate_failures do
      expect(page).to have_content('課題を作成しました')
      expect(page).to have_content('課題ABC')

      within_last_activity do |link|
        expect(page).to have_content(user.name)
        expect(page).to have_content('課題を作成しました')
        expect_link(link, content: '課題ABC', path: project_issue_path(project, Issue.last))
      end
    end
  end

  it do
    click_on '作成する'
    expect(page).to have_content('タイトルを入力してください')
  end

  it do
    fill_in 'form[title]', with: 'Issue 1'
    check 'app_form_continue'
    click_on '作成する'

    fill_in 'form[title]', with: 'Issue 2'
    click_on '作成する'

    fill_in 'form[title]', with: 'Issue 3'
    uncheck 'app_form_continue'
    click_on '作成する'

    aggregate_failures do
      expect(page).to have_content('課題を作成しました')
      expect(page).to have_content('Issue 1')
      expect(page).to have_content('Issue 2')
      expect(page).to have_content('Issue 3')
    end
  end
end
