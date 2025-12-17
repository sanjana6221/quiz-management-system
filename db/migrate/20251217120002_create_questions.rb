class CreateQuestions < ActiveRecord::Migration[8.1]
  def change
    create_table :questions, id: :uuid do |t|
      t.uuid :quiz_id, null: false
      t.text :body, null: false
      t.string :question_type, null: false

      t.timestamps
    end
    add_index :questions, :quiz_id
    add_foreign_key :questions, :quizzes
  end
end
