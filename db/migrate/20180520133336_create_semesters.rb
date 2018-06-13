class CreateSemesters < ActiveRecord::Migration[5.2]
  def change
    create_table :semesters do |t|
      t.integer :start_year, null: false
      t.integer :end_year, null: false
      t.integer :number, null: false
      t.references :course

      t.timestamps
    end
  end
end
