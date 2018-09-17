class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.references :user, foreign_key: true
      t.integer :host
      t.string :content

      t.timestamps
    end
  end
end
