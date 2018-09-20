class RenameLatandLongOnUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :lat, :latitude
    rename_column :users, :lng, :longitude
  end
end
