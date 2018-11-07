class RemoveColumnBirthDateToUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :birth_date
    add_column :users, :adulthood, :boolean
  end
end
