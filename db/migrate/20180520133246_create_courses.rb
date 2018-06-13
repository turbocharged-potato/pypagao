class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :code, null: false
      t.references :university

      t.timestamps
    end
  end
end
