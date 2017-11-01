require 'rails_helper'

describe 'メールアドレスで登録する' do
  it do
    name = 'ユーザーA'
    email = 'user.a@gmail.com'

    visit new_sign_up_path
    fill_in 'sign_up[name]', with: name
    fill_in 'sign_up[email]', with: email
    perform_enqueued_jobs do
      click_on '登録する'
    end

    expect(page).to have_content('メールを送信しました')

    open_email(email)
    current_email.click_link 'こちらから登録を完了してください'

    expect(page).to have_content(name)
  end
end
