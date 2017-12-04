module ActivityHelper

  def present_as_link(text)
    href = yield(self)
    link_to(text, href)
  end

  def present_as_text(text)
    text
  end

  def add_issue_comment(content)
    content_tag(:div, truncate(content, length: 55), class: 'tl-Item_OptionalContent')
  end
end
