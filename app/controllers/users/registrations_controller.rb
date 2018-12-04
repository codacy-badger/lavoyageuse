class Users::RegistrationsController < Devise::RegistrationsController
  def edit
    @editable = current_user.edition_delay < DateTime.now
  end
end
