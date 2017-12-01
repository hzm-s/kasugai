module ApplicationHelper
  include LoadingHelper
  include AvatarHelper
  include TooltipHelper
  include ActivityHelper

  WEB_FONT_URL = 'https://fonts.googleapis.com/earlyaccess/roundedmplus1c.css'.freeze

  def web_font_link_tag
    return if Rails.env.test?
    stylesheet_link_tag(WEB_FONT_URL, media: 'all', 'data-turbolinks-track': 'reload')
  end

  def app_dom_id(resource)
    dom_id(resource, 'app')
  end
end
