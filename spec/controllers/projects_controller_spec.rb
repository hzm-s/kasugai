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
    user = sign_up
    project = create_project(user, name: 'abc')

    other_user = sign_up
    sign_in(other_user)

    get :show, params: { id: project.id }
    expect(response).to redirect_to(projects_url)
  end
end
