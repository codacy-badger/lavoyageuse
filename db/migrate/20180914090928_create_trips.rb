class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.references :user, foreign_key: true
      t.integer :host
      t.string :date

      t.timestamps
    end
  end
end
