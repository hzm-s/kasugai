module SharedExpectations
  module Controller
    def expect_already_signed_in
      aggregate_failures do
        expect(flash[:notice]).to eq('ログインしています')
        expect(response).to redirect_to(home_url)
      end
    end
  end
end

RSpec.configure do |c|
  c.include SharedExpectations::Controller, type: :controller
end
