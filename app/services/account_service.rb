class AccountService < ApplicationService

  def delete(user)
    user.account.destroy!
  end
end
