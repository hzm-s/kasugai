module AvatarHelper
  TEMPLATE_DIR = 'shared/user/avatars'.freeze

  def show_user_avatar(user, options = {})
    size = options.delete(:size)
    template =
      case size
      when :sm
        "#{TEMPLATE_DIR}/sm".freeze
      when :lg
        "#{TEMPLATE_DIR}/lg".freeze
      else
        "#{TEMPLATE_DIR}/base".freeze
      end
    render(partial: template, locals: { user: user }, cached: true)
  end
end
