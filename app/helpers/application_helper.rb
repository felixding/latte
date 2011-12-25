module ApplicationHelper
  def _(str)
    str
  end
  
  def current_or_null(condition)
    condition ? "current" : nil
  end
end