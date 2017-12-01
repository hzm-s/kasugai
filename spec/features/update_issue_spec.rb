require 'rails_helper'

describe '課題の編集' do
  let(:user) { sign_up }
  let(:project) { create_project(user, name: 'ABC') }

  let(:issue) { create_issue(user.as_member_of(project), title: old[:title], content: old[:content]) }
  let(:old) { Hash[title: '課題old', content: '課題本文old'] }
  let(:new) { Hash[title: '課題new', content: '課題本文new'] }

  before do
    sign_in(user)
    visit edit_project_issue_path(project_id: project, id: issue)
  end

  it do
    aggregate_failures do
      expect(find('#app_issue_title').value).to eq(old[:title])
      expect(find('#app_issue_content').value).to eq(old[:content])
    end
  end

  it do
    fill_in 'form[title]', with: new[:title]
    fill_in 'form[content]', with: new[:content]
    click_on '保存する'

    aggregate_failures do
      expect(page).to have_content('課題を更新しました')
      expect(page).to have_content(new[:title])
      within_last_activity(project) do |link|
        expect(page).to have_content(project.name)
        expect(page).to have_content(user.name)
        expect(page).to have_content('課題を編集しました')
        expect_link(link, content: new[:title], path: project_issue_path(project, issue))
      end
    end
  end

  it do
    fill_in 'form[title]', with: ''
    click_on '保存する'
    expect(page).to have_content('タイトルを入力してください')
  end
end
