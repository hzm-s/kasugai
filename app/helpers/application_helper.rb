module ApplicationHelper
  WEB_FONT_URL = 'https://fonts.googleapis.com/earlyaccess/roundedmplus1c.css'.freeze
  LOADING_ICON = '<i class="fa fa-spinner fa-spin"></i>'.freeze

  def web_font_link_tag
    return if Rails.env.test?
    stylesheet_link_tag(WEB_FONT_URL, media: 'all', 'data-turbolinks-track': 'reload')
  end

  def loading_indicator(options = {})
    options.merge({
      behavior: 'loader',
      disable_with: LOADING_ICON.html_safe
    })
  end

  def loading_partial
    "<div>#{LOADING_ICON} Loading ...</div>".html_safe
  end

  def app_dom_id(resource)
    dom_id(resource, 'app')
  end
end
