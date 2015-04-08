class Event < ActiveRecord::Base

  belongs_to :group

  scope :upcoming, -> { where("start_datetime >= ?", DateTime.now).order(start_datetime: :asc) }
  scope :recent, -> { where("start_datetime >= ?", DateTime.now - 6.months).order(start_datetime: :asc) }

  def self.create_or_update_event_from_meetup_api_response(response, group_id)
    Event.find_or_create_by(event_id: response.try!(:id),) do |event|
      event.group_id = group_id
      event.event_id = response.try!(:id)
      event.start_datetime = response.try!(:time)
      event.event_url = response.try!(:event_url)
      event.status = response.try!(:status)
      event.yes_rsvp_count = response.try!(:yes_rsvp_count)
    end
  end

end