class Post < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :title, :url
  validates_uniqueness_of :url

end
