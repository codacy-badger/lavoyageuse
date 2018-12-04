class Users::RegistrationsController < Devise::RegistrationsController
  def edit
    @editable = current_user.edition_delay < DateTime.now
  end

  protected

  def after_update_path_for(resource)
      puts 'this is happening yoyo mama'
      flash[:notice] = "Account succesfully updated"
      edit_user_registration_path
  end
end
