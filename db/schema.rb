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

ActiveRecord::Schema.define(version: 20140929165623) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "events", force: true do |t|
    t.datetime "start_datetime"
    t.string   "status"
    t.integer  "group_id"
    t.string   "event_url"
    t.string   "event_id"
    t.integer  "yes_rsvp_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

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

  add_index "groups", ["latitude", "longitude"], name: "index_groups_on_latitude_and_longitude", using: :btree
  add_index "groups", ["slug"], name: "index_groups_on_slug", unique: true, using: :btree

  create_table "links", force: true do |t|
    t.string   "user_id"
    t.string   "title"
    t.string   "url"
    t.text     "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
  end

  add_index "links", ["cached_votes_down"], name: "index_links_on_cached_votes_down", using: :btree
  add_index "links", ["cached_votes_score"], name: "index_links_on_cached_votes_score", using: :btree
  add_index "links", ["cached_votes_total"], name: "index_links_on_cached_votes_total", using: :btree
  add_index "links", ["cached_votes_up"], name: "index_links_on_cached_votes_up", using: :btree
  add_index "links", ["cached_weighted_average"], name: "index_links_on_cached_weighted_average", using: :btree
  add_index "links", ["cached_weighted_score"], name: "index_links_on_cached_weighted_score", using: :btree
  add_index "links", ["cached_weighted_total"], name: "index_links_on_cached_weighted_total", using: :btree

  create_table "peers", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  create_table "role_assignments", force: true do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
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
    t.string   "email",                   default: "",   null: false
    t.string   "remember_token"
    t.boolean  "newsletter_subscription", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",      default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
