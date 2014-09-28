class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string "user_id"
      t.string "title"
      t.string "url"
      t.text "reason"

      t.timestamps
    end
  end
end
