class CreatePeers < ActiveRecord::Migration
  def change
    create_table :peers do |t|
      t.integer "user_id"
      t.boolean "newsletter_subscription", default: true

      t.timestamps
    end
  end
end
