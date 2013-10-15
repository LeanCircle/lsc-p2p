class AddStartupDataToPeer < ActiveRecord::Migration
  def change
    add_column :peers, :startup_info, :string
    add_column :peers, :startup_role, :string
    add_column :peers, :startup_market, :string
    add_column :peers, :startup_persona, :text
    add_column :peers, :startup_time, :string
    add_column :peers, :startup_interviews, :string
    add_column :peers, :startup_customers, :string
    add_column :peers, :startup_pmf, :text
    add_column :peers, :startup_metrics, :text
    add_column :peers, :startup_stage, :string
  end
end
