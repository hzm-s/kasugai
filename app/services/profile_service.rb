class ProfileService < ApplicationService

  def update(user, params)
    return failure(params: params) unless params.valid?

    user.initials = params.initials
    user.name = params.name
    user.save!

    success
  end
end
