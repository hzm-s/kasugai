class SignInForm
  include ActiveModel::Model

  attr_accessor :email

  def name
    email
  end
end
