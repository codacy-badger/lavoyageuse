class RenameCardIdToUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :cardid, :id_card
  end
end
