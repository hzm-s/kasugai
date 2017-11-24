require 'rails_helper'

describe SessionsController do
  describe '#create' do
    let(:user) { sign_up }

    context '未ログイン' do
      it do
        token = get_sign_in_token(user.email)
        session[:will_remove] = 123

        get :create, params: { token: token }

        aggregate_failures do
          expect(session[:user_id]).to eq(user.id)
          expect(session[:will_remove]).to be_nil
          expect(cookies.signed[:user_id]).to eq(user.id)
        end
      end
    end

    context 'ログイン済み' do
      it do
        sign_in(user)
        get :create, params: { token: 'dummy' }
        expect_already_signed_in
      end
    end
  end

  describe '#destroy' do
    let(:user) { sign_up }

    context '未ログイン' do
      it do
        delete :destroy
        expect_ensure_signed_in
      end
    end

    context 'ログイン済み' do
      it do
        sign_in(user)
        delete :destroy

        aggregate_failures do
          expect(session[:user_id]).to be_nil
          expect(cookies.signed[:user_id]).to be_nil
        end
      end
    end
  end
end
