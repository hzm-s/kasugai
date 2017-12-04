module Expectations
  module Common
    def within_last_activity
      visit timeline_path
      within("#app_project_activity_#{ProjectActivity.last.id}") do
        link_to_target = first('a')
        yield(link_to_target)
      end
    end

    def expect_link(element, content:, path:)
      expect(element.text).to have_content(content)
      expect(element[:href]).to have_content(path)
    end
  end

  module Features
    include Common
  end

  module System
    include Common
  end

  module Controllers
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
      aggregate_failures do
        expect(flash[:notice]).to be_nil
        expect(response).to redirect_to(projects_url)
      end
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
  c.include Expectations::Controllers, type: :controller
  c.include Expectations::Features, type: :feature
  c.include Expectations::System, type: :system
end
