class AddAvailabilityDataToPeers < ActiveRecord::Migration
  def change
    add_column :peers, :availability_location, :text
    add_column :peers, :availability_time, :string
    add_column :peers, :availability_team, :string
  end
end
