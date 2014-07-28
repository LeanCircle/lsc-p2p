class Event < ActiveRecord::Base

  belongs_to :group

  def self.next
    where("start_datetime > ? AND published_status = ? AND status = ?", Time.now, "published", "upcoming")
  end
end