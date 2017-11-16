class ProfileService < ApplicationService

  def update(user, params)
    return failure(params: params) unless params.valid?

    user.initials = params.initials
    user.name = params.name
    user.save!

    success
  end

  def update_theme(user, theme)
    return failure unless UserTheme.exist?(theme)

    user.theme = theme
    user.save

    success
  end
end
