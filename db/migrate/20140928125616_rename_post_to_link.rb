class RenamePostToLink < ActiveRecord::Migration
  def change
    rename_table :posts, :links
  end
end
