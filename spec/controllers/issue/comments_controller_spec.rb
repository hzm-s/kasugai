require 'rails_helper'

describe Issue::CommentsController do
  it do
    get :index, xhr: true, params: { issue_id: 'dummy' }
    expect_xhr_ensure_signed_in
  end

  it do
    post :create, xhr: true, params: { issue_id: 'dummy' }
    expect_xhr_ensure_signed_in
  end

  context do
    include_context '2人のユーザーがそれぞれのプロジェクトで課題を作成している'

    before { sign_in(user_b) }

    it do
      get :index, xhr: true, params: { issue_id: issue_a }
      expect_xhr_ensure_project_member
    end

    it do
      post :create, xhr: true, params: { issue_id: issue_a }
      expect_xhr_ensure_project_member
    end
  end
end
