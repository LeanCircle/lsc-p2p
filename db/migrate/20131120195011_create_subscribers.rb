class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.string :name
      t.string :email
      t.boolean :peer
      t.boolean :direct

      t.timestamps
    end
  end
end
