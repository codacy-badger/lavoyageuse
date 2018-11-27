class AddWhistledToComment < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :whistled, :boolean
  end
end
