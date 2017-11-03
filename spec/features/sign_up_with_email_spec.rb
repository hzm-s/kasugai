require 'rails_helper'

describe 'メールアドレスで登録する' do
  let(:name) { 'ユーザーA' }
  let(:email) { 'user.a@gmail.com' }

  context '未登録の場合' do
    it do
      submit_form do
        fill_in 'form[name]', with: name
        fill_in 'form[email]', with: email
      end

      expect(page).to have_content('ユーザー登録確認メールを送信しました。')

      open_email(email)
      current_email.click_link 'こちらから登録を完了してください'

      expect(page).to have_content(name)
    end
  end

  context '登録済みの場合' do
    before do
      sign_up(name: name, email: email)
    end

    it do
      submit_form do
        fill_in 'form[name]', with: name
        fill_in 'form[email]', with: email
      end

      expect(page).to have_content('ログインメールを送信しました。')

      open_email(email)
      current_email.click_link 'ログインする'

      expect(page).to have_content(name)
    end
  end

  context '入力エラー' do
    it do
      submit_form do
        fill_in 'form[name]', with: name
      end
      expect(page).to have_content('入力してください')
    end
  end

  context '15分より後にアクセスした場合' do
    it do
      now = Time.current

      Timecop.travel(now) do
        submit_form do
          fill_in 'form[name]', with: name
          fill_in 'form[email]', with: email
        end
      end

      Timecop.travel(now + 15.minutes + 1.second) do
        open_email(email)
        current_email.click_link 'こちらから登録を完了してください'
      end

      expect(page).to have_content('もう一度お試しください')
    end
  end

  context '複数回登録しようとした場合' do
    it do
      submit_form do
        fill_in 'form[name]', with: name
        fill_in 'form[email]', with: email
      end
      open_email(email)
      mail1 = current_email

      submit_form do
        fill_in 'form[name]', with: name
        fill_in 'form[email]', with: email
      end
      open_email(email)
      mail2 = current_email

      mail1.click_link 'こちらから登録を完了してください'
      expect(page).to have_content('もう一度お試しください')
    end
  end

  private

    def submit_form
      visit new_sign_up_path
      yield
      perform_enqueued_jobs do
        click_on '続ける'
      end
    end
end
