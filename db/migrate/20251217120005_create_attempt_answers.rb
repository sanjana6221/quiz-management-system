class CreateAttemptAnswers < ActiveRecord::Migration[8.1]
  def change
    create_table :attempt_answers do |t|
      t.bigint :submission_id, null: false
      t.bigint :question_id, null: false
      t.text :selected_option_ids
      t.boolean :correct

      t.timestamps
    end
    add_index :attempt_answers, :submission_id
    add_index :attempt_answers, :question_id
    add_foreign_key :attempt_answers, :submissions
    add_foreign_key :attempt_answers, :questions
  end
end
