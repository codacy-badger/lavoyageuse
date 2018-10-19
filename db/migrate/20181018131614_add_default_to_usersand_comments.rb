class AddDefaultToUsersandComments < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :role, :integer, default: 0
    change_column :comments, :suspended, :boolean, default: false
  end
end
