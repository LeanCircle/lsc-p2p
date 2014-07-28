class Event < ActiveRecord::Base

  belongs_to :group

  def self.upcoming
    where("start_datetime > ? AND status = ?", Time.now, "upcoming").order(start_datetime: :asc)
  end

end