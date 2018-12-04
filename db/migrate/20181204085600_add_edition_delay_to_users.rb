class AddEditionDelayToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :edition_delay, :datetime
  end
end
