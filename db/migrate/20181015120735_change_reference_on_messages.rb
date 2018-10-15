class ChangeReferenceOnMessages < ActiveRecord::Migration[5.1]
  def change
    remove_column :messages, :user_id
    remove_column :messages, :host

    add_column :messages, "traveller_id", :integer
    add_column :messages, "host_id", :integer

    add_index :messages, "traveller_id", name: "index_messages_on_assigner_id"
    add_index :messages, "host_id", name: "index_messages_on_host_id"
  end
end
