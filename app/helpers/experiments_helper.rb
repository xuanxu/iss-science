module ExperimentsHelper
  def revised_icon(exper, size=16)
    if exper.revised
      "<img src='/checked.png' width='#{size}px'>".html_safe
    end
  end
end
