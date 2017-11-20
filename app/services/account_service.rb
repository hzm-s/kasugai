class AccountService < ApplicationService

  def delete(user)
    user.delete_account!
  end
end
