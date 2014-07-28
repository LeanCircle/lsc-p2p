class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime "start_datetime"
      t.string "published_status"
      t.string "status"
      t.integer  "group_id"
      t.string   "event_url"
      t.string  "event_id"
      t.integer  "yes_rsvp_count"

      t.timestamps
    end
  end

end
