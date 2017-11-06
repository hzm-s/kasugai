require 'rails_helper'

describe ProfileController do
  it do
    get :edit
    expect_ensure_signed_in
  end

  it do
    patch :update
    expect_ensure_signed_in
  end
end
