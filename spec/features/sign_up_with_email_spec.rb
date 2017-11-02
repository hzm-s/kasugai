require 'rails_helper'

describe 'メールアドレスで登録する' do
  let(:name) { 'ユーザーA' }
  let(:email) { 'user.a@gmail.com' }

  context '未登録の場合' do
    it do
      visit new_sign_up_request_path
      fill_in 'sign_up_request[name]', with: name
      fill_in 'sign_up_request[email]', with: email
      perform_enqueued_jobs do
        click_on '登録する'
      end

      expect(page).to have_content('ユーザー登録確認メールを送信しました。')

      open_email(email)
      current_email.click_link 'こちらから登録を完了してください'

      expect(page).to have_content(name)
    end
  end

  xcontext '登録済みの場合' do
    before do
      Reception
        .create_for_sign_up(name: name, email: email)
        .commit_sign_up
    end

    it do
      visit new_sign_up_request_path
      fill_in 'sign_up_request[name]', with: name
      fill_in 'sign_up_request[email]', with: email
      perform_enqueued_jobs do
        click_on '登録する'
      end

      expect(page).to have_content('ログイン確認メールを送信しました。')

      open_email(email)
      current_email.click_link 'ログインする'

      expect(page).to have_content(name)
    end
  end
end
