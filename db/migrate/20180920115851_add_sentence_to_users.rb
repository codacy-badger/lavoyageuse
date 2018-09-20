class AddSentenceToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :sentence, :string
  end
end
