class CreatePapers < ActiveRecord::Migration[5.2]
  def change
    create_table :papers do |t|
      t.string :name
      t.references :semester, foreign_key: true

      t.timestamps
    end
  end
end
