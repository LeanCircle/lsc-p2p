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

ActiveRecord::Schema.define(version: 20131230015859) do

  create_table "groups", force: true do |t|
    t.integer  "user_id"
    t.integer  "meetup_id"
    t.string   "organizer_id"
    t.string   "name"
    t.text     "description"
    t.string   "meetup_link"
    t.string   "facebook_link"
    t.string   "twitter_link"
    t.string   "linkedin_link"
    t.string   "googleplus_link"
    t.string   "other_link"
    t.string   "city"
    t.string   "country"
    t.string   "country_code"
    t.string   "province"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.string   "highres_photo_url"
    t.string   "photo_url"
    t.string   "thumbnail_url"
    t.string   "join_mode"
    t.string   "visibility"
    t.boolean  "approval",          default: false
    t.boolean  "lsc",               default: false
    t.integer  "members_count"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["latitude", "longitude"], name: "index_groups_on_latitude_and_longitude"
  add_index "groups", ["slug"], name: "index_groups_on_slug", unique: true

  create_table "peers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.text     "availability_location"
    t.string   "availability_time"
    t.string   "availability_team"
    t.string   "startup_info"
    t.string   "startup_role"
    t.string   "startup_market"
    t.text     "startup_persona"
    t.string   "startup_time"
    t.string   "startup_interviews"
    t.string   "startup_customers"
    t.text     "startup_pmf"
    t.text     "startup_metrics"
    t.string   "startup_stage"
    t.string   "runway_desc"
    t.string   "runway_milestone"
    t.text     "runway_constraints"
    t.string   "stripe_customer_id"
    t.boolean  "newsletter_subscription", default: true
  end

  create_table "role_assignments", force: true do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscribers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "peer"
    t.boolean  "direct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "remember_token"
    t.string   "stripe_customer_id"
    t.boolean  "newsletter_subscription", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
