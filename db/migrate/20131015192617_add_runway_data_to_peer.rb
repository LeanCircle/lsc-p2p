class AddRunwayDataToPeer < ActiveRecord::Migration
  def change
    add_column :peers, :runway_desc, :string
    add_column :peers, :runway_milestone, :string
    add_column :peers, :runway_constraints, :text
  end
end
