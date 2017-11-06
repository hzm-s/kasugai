class Project::BookmarkedIssuesController < ApplicationController

  def index
    render partial: 'list'
  end
end
