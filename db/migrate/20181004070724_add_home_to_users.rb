class AddHomeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :home, :string
  end
end
