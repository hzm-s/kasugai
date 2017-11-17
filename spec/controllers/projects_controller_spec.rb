require 'rails_helper'

describe ProjectsController do
  it do
    get :new
    expect_ensure_signed_in
  end

  it do
    get :index
    expect_ensure_signed_in
  end

  it do
    post :create
    expect_ensure_signed_in
  end

  it do
    get :show, params: { id: 'dummy' }
    expect_ensure_signed_in
  end

  it do
    get :edit, params: { id: 'dummy' }
    expect_ensure_signed_in
  end

  it do
    patch :update, params: { id: 'dummy' }
    expect_ensure_signed_in
  end

  context do
    include_context '2人のユーザーがそれぞれプロジェクトを作成している'

    it do
      sign_in(user_b)
      get :show, params: { id: project_a.id }
      expect_ensure_project_member
    end

    it do
      sign_in(user_b)
      get :edit, params: { id: project_a.id }
      expect_ensure_project_member
    end

    it do
      sign_in(user_b)
      patch :update, params: { id: project_a.id }
      expect_ensure_project_member
    end
  end
end
