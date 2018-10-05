class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :cookie
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

  def cookie
    @cookie = cookies[:lavoyageuse].present?
  end

  def current_user?
    current_user.id == params[:user_id].to_i
  end

  def email_valid(email)
    mail_regex = /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/
    email =~ mail_regex && email.length > 8
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone, :address, :birth_date, :email, :password, :photo, :latitude, :longitude, :city, :sentence])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone, :address, :birth_date, :email, :password, :photo, :latitude, :longitude, :city, :sentence])
  end
end
