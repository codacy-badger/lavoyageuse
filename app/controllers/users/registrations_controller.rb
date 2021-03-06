class Users::RegistrationsController < Devise::RegistrationsController
  def edit
    @editable = current_user.edition_delay < DateTime.now
  end

  protected

  def after_update_path_for(resource)
    flash[:success] = t('.account_updated_successfully')
    edit_user_registration_path
  end

  def after_inactive_sign_up_path_for(resource)
    welcome_path
  end

end
