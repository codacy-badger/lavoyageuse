class AddNewslettersToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :newsletter, :boolean
  end
end
