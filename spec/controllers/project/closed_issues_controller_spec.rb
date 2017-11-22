require 'rails_helper'

describe Project::ClosedIssuesController do
  it do
    get :index, params: { project_id: 'dummy' }
    expect_ensure_signed_in
  end

  it do
    get :show, params: { project_id: 'dummy', id: 'dummy' }
    expect_ensure_signed_in
  end

  it do
    post :create, params: { project_id: 'dummy' }
    expect_ensure_signed_in
  end

  it do
    delete :destroy, params: { project_id: 'dummy', id: 'dummy' }
    expect_ensure_signed_in
  end

  context do
    include_context '2人のユーザーがそれぞれプロジェクトを作成している'

    before { sign_in(user_b) }

    it do
      get :index, params: { project_id: project_a }
      expect_ensure_project_member
    end

    it do
      get :show, params: { project_id: project_a, id: 'dummy' }
      expect_ensure_project_member
    end

    it do
      post :create, params: { project_id: project_a }
      expect_ensure_project_member
    end

    it do
      delete :destroy, params: { project_id: project_a, id: 'dummy' }
      expect_ensure_project_member
    end
  end
end
