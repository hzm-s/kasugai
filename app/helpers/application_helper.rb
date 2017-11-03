module ApplicationHelper
  WEB_FONT_URL = 'https://fonts.googleapis.com/earlyaccess/roundedmplus1c.css'.freeze

  def web_font_link_tag
    return if Rails.env.test?
    stylesheet_link_tag(WEB_FONT_URL, media: 'all', 'data-turbolinks-track': 'reload')
  end

  def loading_indicator(options = {})
    options.merge({
      behavior: 'loader',
      disable_with: '<i class="fa fa-spinner fa-spin"></i>'.html_safe
    })
  end
end
