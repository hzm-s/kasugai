module AvatarHelper
  def show_user_avatar(user, options = {})
    size = options.delete(:size)
    extra_class = options.delete(:class)
    _options = {
      class: avatar_css_class(theme: user.theme, size: size) + " #{extra_class}"
    }.merge(options)
    content_tag(:div, user.initials, _options)
  end

  def avatar_css_class(theme:, size: nil)
    size_suffix =
      if size
        "-#{size}"
      end
    "usr-Avatar#{size_suffix} usr-Avatar-#{theme}"
  end
end
