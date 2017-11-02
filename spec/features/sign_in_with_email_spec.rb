require 'rails_helper'

describe 'メールでログイン' do
  let(:user) { sign_up }

  context '登録済みの場合' do
    it do
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

  context '15分より後にアクセスした場合' do
    it do
      now = Time.current

      Timecop.travel(now) do
        submit_form do
          fill_in 'form[email]', with: user.email
        end
      end

      Timecop.travel(now + 15.minutes + 1.second) do
        open_email(user.email)
        current_email.click_link 'ログインする'
      end

      expect(page).to have_content('もう一度お試しください')
    end
  end

  context '複数回ログインしようとした場合' do
    it do
      submit_form do
        fill_in 'form[email]', with: user.email
      end
      open_email(user.email)
      mail1 = current_email

      submit_form do
        fill_in 'form[email]', with: user.email
      end
      open_email(user.email)
      mail2 = current_email

      mail1.click_link 'ログインする'
      expect(page).to have_content('もう一度お試しください')
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
