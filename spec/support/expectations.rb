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

    def expect_ensure_project_member
      expect(response).to redirect_to(projects_url)
    end

    def expect_xhr_ensure_signed_in
      expect(response).to have_http_status(:forbidden)
    end

    def expect_xhr_ensure_project_member
      expect(response).to have_http_status(:forbidden)
    end
  end
end

RSpec.configure do |c|
  c.include Expectations::Controller, type: :controller
end
