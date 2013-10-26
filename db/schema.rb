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

ActiveRecord::Schema.define(version: 20131026165440) do

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

end
