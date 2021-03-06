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

  def me?
    current_user == @user
  end

  def existing_exchanges?
    current_user.posted_messages.where(host: @user).count > 0
  end

  def existing_trips?
    current_user.announced_trips.where(host: @user).count > 0
  end

  def future_trip?
    @trips = current_user.announced_trips.where(host: @user)
    if @trips.count > 0
      @trips.maximum(:end) > DateTime.now
    end
  end

  def moderation
    current_user.moderator
  end

  def beginning_of_last_trip
    current_user.announced_trips.order(:beginning).last.beginning
  end

  def end_of_last_trip
    current_user.announced_trips.order(:end).last.end
  end
end
