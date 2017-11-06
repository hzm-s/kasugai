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
end
