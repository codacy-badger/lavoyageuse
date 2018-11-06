class RenameCardIdToUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :cardid, :id_card
    add_column :users, :id_card, :string
  end
end
