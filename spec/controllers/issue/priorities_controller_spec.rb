require 'rails_helper'

describe Issue::PrioritiesController do
  it do
    patch :update, xhr: true, params: { issue_id: 'dummy' }
    expect_xhr_ensure_signed_in
  end
end
