require 'rails_helper'

describe AccountsController do
  it do
    get :show
    expect_ensure_signed_in
  end

  it do
    delete :destroy
    expect_ensure_signed_in
  end
end
