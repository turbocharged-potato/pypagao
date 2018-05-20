class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string :content
      t.string :imgur
      t.references :question
      t.references :user

      t.timestamps
    end
  end
end
