require 'rails_helper'

describe HomeController do
  context '未ログイン' do
    it do
      get :show
      expect_ensure_signed_in
    end
  end
end
