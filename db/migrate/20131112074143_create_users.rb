class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      t.string  :remember_token
      t.string  :stripe_customer_id
      t.boolean :newsletter_subscription, default: true

      t.timestamps
    end
  end
end
