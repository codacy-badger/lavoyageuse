class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :beginning_date
      t.string :end_date
      t.timestamps
    end
  end
end
