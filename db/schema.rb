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

ActiveRecord::Schema[8.1].define(version: 0) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "tb_books", id: :integer, default: nil, force: :cascade do |t|
    t.text "author", null: false
    t.integer "code", null: false
    t.date "created_at", default: -> { "CURRENT_DATE" }, null: false
    t.text "description", null: false
    t.boolean "is_rent", default: false
    t.text "publisher", null: false
    t.integer "quantity", null: false
    t.integer "rented_by"
    t.text "title", null: false
    t.date "updated_at", default: -> { "CURRENT_DATE" }, null: false
  end

  create_table "tb_rents", id: :integer, default: nil, force: :cascade do |t|
    t.integer "book_id", null: false
    t.date "created_at", default: -> { "CURRENT_DATE" }, null: false
    t.integer "delay_time", default: 0, null: false
    t.boolean "is_late", default: false, null: false
    t.integer "rent_time", null: false
    t.integer "student_id", null: false
  end

  create_table "tb_students", id: :integer, default: nil, force: :cascade do |t|
    t.text "class", null: false
    t.date "created_at", default: -> { "CURRENT_DATE" }, null: false
    t.text "name", null: false
    t.date "updated_at", default: -> { "CURRENT_DATE" }, null: false
  end

  add_foreign_key "tb_books", "tb_students", column: "rented_by", name: "FK_BOOK_STUDENT", validate: false
  add_foreign_key "tb_rents", "tb_books", column: "book_id", name: "FK_RENT_BOOK_ID", validate: false
  add_foreign_key "tb_rents", "tb_students", column: "student_id", name: "FK_RENT_STUDENT_ID", validate: false
end
