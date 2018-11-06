class AddUsersColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_column :users, :birth_date, :string
    add_column :users, :lng, :float
    add_column :users, :lat, :float
    add_column :users, :role, :integer, default: 0
    add_column :users, :id_card, :string
  end
end
