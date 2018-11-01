class AddCurrentToPlan < ActiveRecord::Migration[5.1]
  def change
    add_monetize :plans, :price, currency: { present: false }
  end
end
