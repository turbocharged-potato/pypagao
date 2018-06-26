class AddDomainToUniversity < ActiveRecord::Migration[5.2]
  def change
    add_column :universities, :domain, :string, null: false

    add_index :universities, :domain, unique: true
    add_index :universities, :name, unique: true
  end
end
