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

ActiveRecord::Schema.define(version: 2020_07_19_102519) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "average_caches", force: :cascade do |t|
    t.bigint "rater_id"
    t.string "rateable_type"
    t.bigint "rateable_id"
    t.float "avg", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rateable_type", "rateable_id"], name: "index_average_caches_on_rateable_type_and_rateable_id"
    t.index ["rater_id"], name: "index_average_caches_on_rater_id"
  end

  create_table "careers", force: :cascade do |t|
    t.bigint "expert_id", null: false
    t.date "occurrence_date", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expert_id"], name: "index_careers_on_expert_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.string "name_kana"
    t.integer "gender"
    t.string "age"
    t.string "address"
    t.string "postcode"
    t.string "phone_number"
    t.string "avater_image_id"
    t.boolean "withdraw_status", default: true, null: false
    t.string "provider"
    t.string "uid"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_clients_on_confirmation_token", unique: true
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "problem_id"
    t.bigint "expert_id"
    t.bigint "client_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_comments_on_client_id"
    t.index ["expert_id"], name: "index_comments_on_expert_id"
    t.index ["problem_id"], name: "index_comments_on_problem_id"
  end

  create_table "consultations", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "expert_id", null: false
    t.bigint "trouble_tag_id"
    t.bigint "event_id"
    t.text "content"
    t.integer "reservation_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_consultations_on_client_id"
    t.index ["event_id"], name: "index_consultations_on_event_id"
    t.index ["expert_id"], name: "index_consultations_on_expert_id"
    t.index ["trouble_tag_id"], name: "index_consultations_on_trouble_tag_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "start_event_time", null: false
    t.datetime "end_event_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expertise_tags", force: :cascade do |t|
    t.bigint "expert_id", null: false
    t.bigint "trouble_tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expert_id"], name: "index_expertise_tags_on_expert_id"
    t.index ["trouble_tag_id"], name: "index_expertise_tags_on_trouble_tag_id"
  end

  create_table "experts", force: :cascade do |t|
    t.string "name", null: false
    t.string "name_kana", null: false
    t.integer "gender"
    t.string "age"
    t.string "phone_number", null: false
    t.string "avater_image_id"
    t.text "introduction"
    t.boolean "public_status", null: false
    t.boolean "withdraw_status", default: true, null: false
    t.bigint "office_id"
    t.bigint "job_id"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_experts_on_email", unique: true
    t.index ["job_id"], name: "index_experts_on_job_id"
    t.index ["office_id"], name: "index_experts_on_office_id"
    t.index ["reset_password_token"], name: "index_experts_on_reset_password_token", unique: true
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "expert_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_favorites_on_client_id"
    t.index ["expert_id"], name: "index_favorites_on_expert_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offices", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "tel"
    t.string "postcode"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.datetime "reception_start_time"
    t.datetime "reception_end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "overall_averages", force: :cascade do |t|
    t.string "rateable_type"
    t.bigint "rateable_id"
    t.float "overall_avg", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rateable_type", "rateable_id"], name: "index_overall_averages_on_rateable_type_and_rateable_id"
  end

  create_table "problems", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "trouble_tag_id"
    t.text "content"
    t.integer "priority_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_problems_on_client_id"
    t.index ["trouble_tag_id"], name: "index_problems_on_trouble_tag_id"
  end

  create_table "rates", force: :cascade do |t|
    t.bigint "rater_id"
    t.string "rateable_type"
    t.bigint "rateable_id"
    t.float "stars", null: false
    t.string "dimension"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rateable_type", "rateable_id"], name: "index_rates_on_rateable_type_and_rateable_id"
    t.index ["rater_id"], name: "index_rates_on_rater_id"
  end

  create_table "rating_caches", force: :cascade do |t|
    t.string "cacheable_type"
    t.bigint "cacheable_id"
    t.float "avg", null: false
    t.integer "qty", null: false
    t.string "dimension"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cacheable_type", "cacheable_id"], name: "index_rating_caches_on_cacheable_type_and_cacheable_id"
  end

  create_table "trouble_tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
