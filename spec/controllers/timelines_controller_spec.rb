require 'rails_helper'

describe TimelinesController do
  it do
    get :show
    expect_ensure_signed_in
  end
end
