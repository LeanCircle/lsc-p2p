class AddStripeCustomerIdToPeers < ActiveRecord::Migration
  def change
    add_column :peers, :stripe_customer_id, :string
  end
end
