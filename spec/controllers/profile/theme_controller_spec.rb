require 'rails_helper'

describe Profile::ThemeController do
  it do
    patch :update
    expect_ensure_signed_in
  end
end
