class PagesController < ApplicationController
  layout 'page'

  def show
    render params[:id]
  end
end
