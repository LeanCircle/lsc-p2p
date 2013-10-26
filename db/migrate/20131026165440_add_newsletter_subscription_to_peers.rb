class AddNewsletterSubscriptionToPeers < ActiveRecord::Migration
  def change
    add_column :peers, :newsletter_subscription, :boolean, default: true
  end
end
