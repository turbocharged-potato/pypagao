class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :name
      t.references :paper

      t.timestamps
    end
  end
end
