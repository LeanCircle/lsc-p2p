class RemovePublishedStatus < ActiveRecord::Migration
  def change
    remove_column :events, :published_status
  end
end
