ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :email, :phone, :birth_date, :role, :photo, :id_card, :host, :home, :city
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


  index do
    selectable_column
    column :id
    column :email
    column :first_name
    column :last_name
    column :created_at
    column :address
    column :phone
    column :role
    column :host
    actions
  end

  form do |f|
    f.inputs "Identity" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :phone
      f.input :sentence
      f.input :description
      f.input :role
      f.input :host
    end
    f.actions
  end

  permit_params :name, :email, :admin

  index as: :grid do |user|
    link_to image_tag(user.photo), admin_user_path(user)
  end

end
