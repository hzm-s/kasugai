class SignInForm
  include ActiveModel::Model

  attr_accessor :email

  validates :email, presence: true, email_format: true

  def name
    email
  end
end
