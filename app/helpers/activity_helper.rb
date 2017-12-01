module ActivityHelper

  def present_as_link(text)
    href = yield(self)
    link_to(text, href)
  end

  def present_as_text(text)
    text
  end
end
