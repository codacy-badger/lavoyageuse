module ApplicationHelper
  def flash_icon(key)
    key[-1].to_i != 0 ? key = key.chop : key
    case key
    when "warning"
      return 'fas fa-exclamation-triangle'
    when "alert"
      return 'fas fa-exclamation-circle'
    when "notice"
      return 'far fa-bell'
    when "success"
      return 'far fa-thumbs-up'
    end
  end
end
