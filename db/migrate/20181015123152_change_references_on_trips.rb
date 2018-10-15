class ChangeReferencesOnTrips < ActiveRecord::Migration[5.1]
  def change
    remove_column :trips, :user_id
    remove_column :trips, :host

    add_column :trips, "traveller_id", :integer
    add_column :trips, "host_id", :integer

    add_index :trips, "traveller_id", name: "index_trips_on_assigner_id"
    add_index :trips, "host_id", name: "index_trips_on_host_id"
  end
end
