class AccountsController < ApplicationController
  before_action :ensure_signed_in

  def show
    @projects = Project.for_user(current_user.id)
  end

  def destroy
    AccountService.delete(current_user)
    sign_out
    redirect_to new_sign_in_url, notice: flash_message
  end
end
