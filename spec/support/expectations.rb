module Expectations
  module Controller
    def expect_already_signed_in
      aggregate_failures do
        expect(flash[:notice]).to eq('ログインしています')
        expect(response).to redirect_to(home_url)
      end
    end

    def expect_ensure_signed_in
      aggregate_failures do
        expect(flash[:alert]).to eq('ログインしてください')
        expect(response).to redirect_to(new_sign_in_url)
      end
    end

    def expect_redirect_to_project_list
    end
  end
end

RSpec.configure do |c|
  c.include Expectations::Controller, type: :controller
end
