class CreatePeers < ActiveRecord::Migration
  def change
    create_table :peers do |t|
      t.integer "user_id"

      t.timestamps
    end
  end
end
