# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_20_160036) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.boolean "correct", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "text", limit: 300, default: "", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "title", limit: 200, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gists", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.string "gist_id", null: false
    t.string "url", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_gists_on_question_id"
    t.index ["user_id"], name: "index_gists_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "body", null: false
    t.bigint "test_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["test_id"], name: "index_questions_on_test_id"
  end

  create_table "results", force: :cascade do |t|
    t.bigint "test_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "current_question_id"
    t.integer "correct_answers", default: 0, null: false
    t.integer "answers", default: 0, null: false
    t.index ["current_question_id"], name: "index_results_on_current_question_id"
    t.index ["test_id"], name: "index_results_on_test_id"
    t.index ["user_id"], name: "index_results_on_user_id"
  end

  create_table "tests", force: :cascade do |t|
    t.string "title", limit: 200, null: false
    t.integer "level", default: 0, null: false
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "author_id"
    t.index ["author_id"], name: "index_tests_on_author_id"
    t.index ["category_id"], name: "index_tests_on_category_id"
    t.index ["level", "title"], name: "index_tests_on_level_and_title", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", limit: 200, default: ""
    t.string "name", limit: 200
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "first_name", limit: 200
    t.string "last_name", limit: 200
    t.string "type", limit: 20, default: "User", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "gists", "questions"
  add_foreign_key "gists", "users"
  add_foreign_key "questions", "tests"
  add_foreign_key "results", "questions", column: "current_question_id"
  add_foreign_key "results", "tests"
  add_foreign_key "results", "users"
  add_foreign_key "tests", "categories"
  add_foreign_key "tests", "users", column: "author_id"
end
