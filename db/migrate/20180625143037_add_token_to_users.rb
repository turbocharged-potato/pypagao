class AddTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :token, :string
    add_column :users, :verified, :boolean, default: false, null: false

    add_index :users, :token, unique: true
  end
end
