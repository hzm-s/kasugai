module TooltipHelper
  def tooltip(text, pos: 'up')
    {
      balloon: text,
      balloon_pos: pos
    }
  end
end
