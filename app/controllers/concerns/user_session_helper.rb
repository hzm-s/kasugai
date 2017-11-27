module UserSessionHelper

  def remember_user(user)
    RememberedUser.delete(user.id)
    token = RememberedUser.add(user.id)
    cookies.signed[:remember_token] = { value: token, expires: RememberedUser::EXPIRATION.from_now }
  end

  def forget_user(user)
    RememberedUser.delete(user.id)
    cookies.delete(:remember_token)
    cookies.signed[:remember_token] = nil
  end

  def find_remembered_user
    return nil if (token = remember_token).nil?
    RememberedUser.find_user_by_token(token)
  end

  private

    def remember_token
      cookies.signed[:remember_token]
    end
end
