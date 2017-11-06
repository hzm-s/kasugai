require 'rails_helper'

describe UsersController do
  describe '#create' do
    context 'ログイン済み' do
      it do
        sign_in(sign_up)
        get :create, params: { token: 'dummy' }
        expect_already_signed_in
      end
    end
  end
end
