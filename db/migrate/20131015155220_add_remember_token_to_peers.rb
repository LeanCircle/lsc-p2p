class AddRememberTokenToPeers < ActiveRecord::Migration
  def change
    add_column :peers, :remember_token, :string
  end
end
