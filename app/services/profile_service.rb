class ProfileService < ApplicationService

  def update(user, params)
    return failure(params: params) unless params.valid?

    user.update!(initials: params.initials, name: params.name)
    UserUpdatePropagationJob.perform_later(user)

    success
  end

  def update_theme(user, theme)
    return failure unless UserTheme.exist?(theme)

    user.update!(theme: theme)
    UserUpdatePropagationJob.perform_later(user)

    success
  end
end
