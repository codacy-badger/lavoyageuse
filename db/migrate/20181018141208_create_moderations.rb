class CreateModerations < ActiveRecord::Migration[5.1]
  def change
    create_table :moderations do |t|
      t.string :action

      t.timestamps
    end

    add_column :moderations, "moderator_id", :integer
    add_column :moderations, "moderated_id", :integer

    add_index :moderations, "moderator_id", name: "index_moderations_on_moderator_id"
    add_index :moderations, "moderated_id", name: "index_moderations_on_moderated_id"
  end
end
