class EditProfileForm
  include ActiveModel::Model

  attr_accessor :initials, :name

  validates :initials,
    presence: true,
    length: { is: 2 },
    format: { with: /[A-Za-z]/, message: I18n.t('errors.messages.not_an_alphabetic') }

  def self.fill(user)
    new(
      initials: user.initials,
      name: user.name
    )
  end
end
