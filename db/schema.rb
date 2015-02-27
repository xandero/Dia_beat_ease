# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150227044406) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "activityname"
    t.float    "duration"
    t.integer  "intensity"
    t.datetime "activity_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "bloodsugars", force: :cascade do |t|
    t.float    "bslevel"
    t.datetime "readingtime"
    t.string   "mealtime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "foods", force: :cascade do |t|
    t.string   "foodname"
    t.float    "quantity"
    t.float    "serving_size_qty"
    t.string   "serving_size_unit"
    t.float    "carbs"
    t.float    "serving_size_weight"
    t.float    "insulin_required"
    t.datetime "consumed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "meal_id"
  end

  create_table "meals", force: :cascade do |t|
    t.datetime "meal_time"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.date     "dob"
    t.string   "gender"
    t.float    "weight"
    t.float    "height"
    t.float    "basal_insulin"
    t.float    "bolus_insulin"
    t.string   "diabetes_type"
    t.boolean  "is_admin",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

end
