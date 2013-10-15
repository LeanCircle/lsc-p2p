class AddAvailabilityDataToPeers < ActiveRecord::Migration
  def change
    add_column :peers, :location, :text
    add_column :peers, :time, :text
    add_column :peers, :team, :string
  end
end
