class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :under_construction?
  before_action :authenticate_user!
  before_action :premium_check
  add_flash_types :success, :warning
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource_or_scope)
    if current_user
      users_path
    else
      root_path
    end
  end

  def comment_valid(comment)
    comment.present? && comment.length > 8
  end

  def premium_check
    if current_user && current_user.premium_expiration
      if current_user.premium_expiration < DateTime.now
        current_user.update(premium: false)
      end
    end
  end

  def current_user?
    current_user.id == params[:user_id].to_i
  end

  def me?
    current_user == @user
  end

  def i_am_moderator?
    current_user.moderator
  end

  def email_valid(email)
    mail_regex = /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/
    email =~ mail_regex && email.length > 8
  end

  def under_construction?
    if ENV['UNDER_CONSTRUCTION'] == "true"
      redirect_to under_construction_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone, :address, :adulthood, :email, :password, :photo, :photo_cache, :latitude, :longitude, :city, :sentence, :id_card, :id_card_cache, :womanhood])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone, :address, :adulthood, :email, :password, :photo, :photo_cache, :latitude, :longitude, :city, :sentence, :id_card, :id_card_cache, :womanhood, :suspended, :reported])
  end
end
