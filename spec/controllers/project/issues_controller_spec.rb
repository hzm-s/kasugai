require 'rails_helper'

describe Project::IssuesController do
  it do
    get :new, params: { project_id: 'dummy' }
    expect_ensure_signed_in
  end

  it do
    post :create, params: { project_id: 'dummy' }
    expect_ensure_signed_in
  end

  it do
    get :index, params: { project_id: 'dummy' }
    expect_ensure_signed_in
  end

  context do
    include_context '2人のユーザーがそれぞれプロジェクトを作成している'

    before do
      sign_in(user_b)
    end

    it do
      get :new, params: { project_id: project_a.id }
      expect(response).to redirect_to(projects_url)
    end

    it do
      post :create, params: { project_id: project_a.id }
      expect(response).to redirect_to(projects_url)
    end

    it do
      get :index, params: { project_id: project_a.id }
      expect(response).to redirect_to(projects_url)
    end
  end
end
