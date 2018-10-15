class ChangeReferencesOnComments < ActiveRecord::Migration[5.1]
  def change
    remove_column :comments, :user_id
    remove_column :comments, :host

    add_column :comments, "traveller_id", :integer
    add_column :comments, "host_id", :integer
  end
end
