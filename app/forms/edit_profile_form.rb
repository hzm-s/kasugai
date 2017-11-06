class EditProfileForm
  include ActiveModel::Model

  attr_accessor :initials, :name

  validates :initials, presence: true

  def self.fill(user)
    new(
      initials: user.initials,
      name: user.name
    )
  end
end
