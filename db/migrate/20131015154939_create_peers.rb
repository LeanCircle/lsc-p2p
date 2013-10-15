class CreatePeers < ActiveRecord::Migration
  def change
    create_table :peers do |t|
      t.string :peer_name
      t.string :peer_email

      t.timestamps
    end
  end
end
