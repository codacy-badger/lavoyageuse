class SetDefaultHostValueToUsers < ActiveRecord::Migration[5.1]
  def change
     change_column :users, :host, :integer, default: 0
   end
end
