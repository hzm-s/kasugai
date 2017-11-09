require 'rails_helper'

describe Project::BookmarkedIssuesController do
  it do
    get :index, xhr: true, params: { project_id: 'dummy' }
    expect_ensure_signed_in
  end

  it do
    post :create, xhr: true, params: { project_id: 'dummy' }
    expect_xhr_ensure_signed_in
  end

  it do
    delete :destroy, xhr: true, params: { project_id: 'dummy', id: 'dummy' }
    expect_xhr_ensure_signed_in
  end
end
