class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      # Belongs to User
      t.integer :user_id

      # Identifiers
      t.integer :meetup_id
      t.string :organizer_id

      # Basic info
      t.string :name
      t.text :description

      # Links to various group assets
      t.string :meetup_link
      t.string :facebook_link
      t.string :twitter_link
      t.string :linkedin_link
      t.string :googleplus_link
      t.string :other_link

      # For geolocation
      t.string :city
      t.string :country
      t.string :country_code
      t.string :province
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps

      # Photo urls
      t.string :highres_photo_url
      t.string :photo_url
      t.string :thumbnail_url

      # Misc info given by meetup
      t.string :join_mode
      t.string :visibility

      # For authorized meetups only
      t.boolean :approval, :default => false
      t.boolean :lsc, :default => false

      # Groups metrics
      t.integer :members_count

      # For friendly_id
      t.string :slug

      t.timestamps
    end

    # Indexes for friendly_id & geolocate
    add_index :groups, :slug, unique: true
    add_index :groups, [:latitude, :longitude]

  end
end
