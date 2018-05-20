class CreatePapers < ActiveRecord::Migration[5.2]
  def change
    create_table :papers do |t|
      t.string :name
      t.references :semester

      t.timestamps
    end
  end
end
