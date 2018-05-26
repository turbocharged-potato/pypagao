class CreateSemesters < ActiveRecord::Migration[5.2]
  def change
    create_table :semesters do |t|
      t.integer :start_year
      t.integer :end_year
      t.integer :number
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
