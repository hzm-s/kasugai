class AccountsController < ApplicationController

  def destroy
    AccountService.delete(current_user)
    sign_out
    redirect_to new_sign_in_url, notice: flash_message
  end
end
