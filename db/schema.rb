# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2025_12_17_120005) do
  create_table "admin_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
  end

  create_table "attempt_answers", force: :cascade do |t|
    t.boolean "correct"
    t.datetime "created_at", null: false
    t.bigint "question_id", null: false
    t.text "selected_option_ids"
    t.bigint "submission_id", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_attempt_answers_on_question_id"
    t.index ["submission_id"], name: "index_attempt_answers_on_submission_id"
  end

  create_table "options", force: :cascade do |t|
    t.boolean "correct", default: false
    t.datetime "created_at", null: false
    t.bigint "question_id", null: false
    t.string "text", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_options_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.string "question_type", null: false
    t.bigint "quiz_id", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_questions_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "title", null: false
    t.datetime "updated_at", null: false
  end

  create_table "submissions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "quiz_id", null: false
    t.integer "score"
    t.integer "total_questions"
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_submissions_on_quiz_id"
  end

  add_foreign_key "attempt_answers", "questions"
  add_foreign_key "attempt_answers", "submissions"
  add_foreign_key "options", "questions"
  add_foreign_key "questions", "quizzes"
  add_foreign_key "submissions", "quizzes"
end
