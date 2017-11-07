require 'rails_helper'

describe '課題の追加' do
  it do
    user = sign_up
    project = create_project(user, name: 'ABC')
    sign_in(user)

    visit new_project_issue_path(project_id: project.id)
    fill_in 'form[title]', with: '課題ABC'
    fill_in 'form[content]', with: '課題本文'
    click_on '作成する'

    aggregate_failures do
      expect(page).to have_content('課題を作成しました')
      expect(page).to have_content('課題ABC')
    end
  end
end
