require 'rails_helper'

describe Project::BookmarkedIssuesController do
  it do
    get :index, xhr: true, params: { project_id: 'dummy' }
    expect_xhr_ensure_signed_in
  end

  it do
    post :create, xhr: true, params: { project_id: 'dummy' }
    expect_xhr_ensure_signed_in
  end

  it do
    delete :destroy, xhr: true, params: { project_id: 'dummy', id: 'dummy' }
    expect_xhr_ensure_signed_in
  end

  context do
    include_context '2人のユーザーがそれぞれプロジェクトを作成している'

    before { sign_in(user_b) }

    it do
      get :index, xhr: true, params: { project_id: project_a }
      expect_xhr_ensure_project_member
    end

    it do
      post :create, xhr: true, params: { project_id: project_a }
      expect_xhr_ensure_project_member
    end

    it do
      delete :destroy, xhr: true, params: { project_id: project_a, id: 'dummy' }
      expect_xhr_ensure_project_member
    end
  end
end
