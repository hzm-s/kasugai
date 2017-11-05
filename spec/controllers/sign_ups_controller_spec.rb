require 'rails_helper'

describe SignUpsController do
  describe '#new' do
    context 'ログイン済み' do
      it do
        sign_in(sign_up.email)
        get :new
        expect_already_signed_in
      end
    end
  end

  describe '#create' do
    context 'ログイン済み' do
      it do
        sign_in(sign_up.email)
        post :create, params: {}
        expect_already_signed_in
      end
    end
  end
end
