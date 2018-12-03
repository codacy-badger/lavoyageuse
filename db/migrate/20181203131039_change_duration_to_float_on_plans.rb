class ChangeDurationToFloatOnPlans < ActiveRecord::Migration[5.1]
  def change
    change_column :plans, :duration, :float
  end
end
