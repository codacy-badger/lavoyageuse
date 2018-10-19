class AddSuspendedToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :suspended, :boolean, default: false
  end
end
