class CreateOptions < ActiveRecord::Migration[8.1]
  def change
    create_table :options do |t|
      t.bigint :question_id, null: false
      t.string :text, null: false
      t.boolean :correct, default: false

      t.timestamps
    end
    add_index :options, :question_id
    add_foreign_key :options, :questions
  end
end
