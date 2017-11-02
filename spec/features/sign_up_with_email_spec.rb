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

    context '入力エラー' do
      it do
        submit_form do
          fill_in 'form[name]', with: name
        end
        expect(page).to have_content('入力してください')
      end
    end
  end

  context '登録済みの場合' do
    before do
      SignUp
        .create(name: name, email: email)
        .complete
    end

    it do
      submit_form do
        fill_in 'form[name]', with: name
        fill_in 'form[email]', with: email
      end

      expect(page).to have_content('ログイン確認メールを送信しました。')

      open_email(email)
      current_email.click_link 'ログインする'

      expect(page).to have_content(name)
    end

    context '入力エラー' do
      it do
        submit_form do
          fill_in 'form[name]', with: name
        end
        expect(page).to have_content('入力してください')
      end
    end
  end

  private

    def submit_form
      visit new_sign_up_path
      yield
      perform_enqueued_jobs do
        click_on '登録する'
      end
    end
end
