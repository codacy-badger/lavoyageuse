class RemoveColumDateonPlans < ActiveRecord::Migration[5.1]
  def change
    remove_column :plans, :beginning_date
    remove_column :plans, :end_date
    add_column :plans, :duration, :integer
  end
end
