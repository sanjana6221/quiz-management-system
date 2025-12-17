class CreateSubmissions < ActiveRecord::Migration[8.1]
  def change
    create_table :submissions, id: :uuid do |t|
      t.uuid :quiz_id, null: false
      t.integer :score
      t.integer :total_questions

      t.timestamps
    end
    add_index :submissions, :quiz_id
    add_foreign_key :submissions, :quizzes
  end
end
