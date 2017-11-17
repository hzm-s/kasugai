module LoadingHelper
  LOADING_ICON = '<i class="fa fa-spinner fa-spin"></i>'.freeze

  def loading_indicator
    {
      behavior: 'loader',
      disable_with: LOADING_ICON.html_safe
    }
  end

  def loading_partial
    "<div>#{LOADING_ICON} Loading ...</div>".html_safe
  end
end
