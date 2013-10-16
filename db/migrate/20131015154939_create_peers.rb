class CreatePeers < ActiveRecord::Migration
  def change
    create_table :peers do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
