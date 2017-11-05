class HomeController < ApplicationController
  before_action :ensure_signed_in
end
