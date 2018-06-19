class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :name, null: false
      t.references :paper

      t.timestamps
    end
  end
end
