require 'rails_helper'

describe 'メールアドレスで登録する' do
  let(:name) { 'ユーザーA' }
  let(:email) { 'user.a@gmail.com' }

  context '未登録の場合' do
    it do
      visit new_sign_up_path
      fill_in 'form[name]', with: name
      fill_in 'form[email]', with: email
      perform_enqueued_jobs do
        click_on '登録する'
      end

      expect(page).to have_content('ユーザー登録確認メールを送信しました。')

      open_email(email)
      current_email.click_link 'こちらから登録を完了してください'

      expect(page).to have_content(name)
    end

    context '名前が未入力' do
      it do
        visit new_sign_up_path
        fill_in 'form[name]', with: name
        click_on '登録する'

        expect(page).to have_content('入力してください')
      end
    end

    context 'メールアドレスが未入力' do
      it do
        visit new_sign_up_path
        fill_in 'form[email]', with: email
        click_on '登録する'

        expect(page).to have_content('入力してください')
      end
    end

    context '不正なメールアドレス' do
      it do
        visit new_sign_up_path
        fill_in 'form[name]', with: name
        fill_in 'form[email]', with: 'wrong.email'
        click_on '登録する'

        expect(page).to have_content('正しいメールアドレスではありません')
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
      visit new_sign_up_path
      fill_in 'form[name]', with: name
      fill_in 'form[email]', with: email
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
