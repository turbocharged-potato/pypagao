class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :code
      t.references :university, foreign_key: true

      t.timestamps
    end
  end
end
