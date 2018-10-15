class AddEndToTrips < ActiveRecord::Migration[5.1]
  def change
    add_column :trips, :end, :string
    rename_column :trips, :date, :beginning
  end
end
