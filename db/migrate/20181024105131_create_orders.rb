class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :state
      t.string :plan_sku
      t.monetize :amount
      t.json :payment
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
