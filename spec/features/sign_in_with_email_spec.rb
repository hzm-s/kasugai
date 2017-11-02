require 'rails_helper'

describe 'メールでログイン' do
  context '登録済みの場合' do
    it do
      user = sign_up

      submit_form do
        fill_in 'form[email]', with: user.email
      end

      expect(page).to have_content('ログイン確認メールを送信しました。')

      open_email(user.email)
      current_email.click_link 'ログインする'

      expect(page).to have_content(user.name)
    end
  end

  context '未登録の場合' do
    let(:email) { 'user.a@gmail.com' }

    it do
      submit_form do
        fill_in 'form[email]', with: email
      end

      expect(page).to have_content('ユーザー登録確認メールを送信しました。')

      open_email(email)
      current_email.click_link 'こちらから登録を完了してください'

      expect(page).to have_content(email)
    end
  end

  context '入力エラー' do
    it do
      submit_form {}
      expect(page).to have_content('入力してください')
    end
  end

  private

    def submit_form
      visit new_sign_in_path
      yield
      perform_enqueued_jobs do
        click_on 'ログインする'
      end
    end
end
