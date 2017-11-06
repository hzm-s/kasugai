class EditProfileForm
  include ActiveModel::Model

  attr_accessor :initials, :name

  def self.fill(user)
    new(
      initials: user.initials,
      name: user.name
    )
  end
end
