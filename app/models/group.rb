class Group < ActiveRecord::Base
  attr_accessor :meetup_identifier

  #belongs_to :authentication #, :primary_key => "id", :foreign_key => "auth_id" # TODO: scope this to :provider => "meetup"
  belongs_to :user
  #has_many :events

  validates_presence_of :name
  validates_uniqueness_of :name,
                          :meetup_id,
                          :meetup_link, :allow_blank => true
  after_validation :geocode, :reverse_geocode

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude do |group, results|
    if geo = results.first
      group.city = geo.city
      group.province = geo.state_code
      group.country_code = geo.country_code
      group.country = geo.country
    end
  end

  extend FriendlyId
  friendly_id :name, use: :slugged

  scope :approved, -> { where(approval: true) }
  scope :by_country, -> { select(:country).uniq.order("country asc") }
  scope :lsc, -> { where(:lsc => true) }

  def link
    [meetup_link,
     facebook_link,
     linkedin_link,
     googleplus_link,
     other_link,
     twitter_link].compact.first
  end

  #def self.country_count(country)
  #  count(:conditions => "country = '#{country}'")
  #end
  #
  #def self.percentage_lsc
  #  (Float(lsc.count) / Float(count)) * 100
  #end

  def address
    [city, province, country].compact.join(', ')
  end

  def address_no_country
    [city, province].compact.join(', ')
  end

  #def average_attendance(events)
  #  events.average(:yes_rsvp_count).round(2)
  #end

  # def self.fetch_from_meetup(query)
  #   init_rmeetup
  #   method = query_method(query)
  #   query = clean_query(query)
  #   response = RMeetup::Client.fetch( :groups,{ method => query }).first
  #   create_from_meetup_api_response(response)
  # end

  # def self.fetch_events_from_meetup(group)
  #   init_rmeetup
  #   responses = RMeetup::Client.fetch(:events,{:group_id => group.meetup_id, :status => 'past'})
  #   responses += RMeetup::Client.fetch(:events,{:group_id => group.meetup_id, :status => 'upcoming', :desc => true}).last(5)
  #   responses.each do |response|
  #      create_events_from_meetup_api_response(response,group.id)
  #   end
  # end
  #
  #def self.fetch_members_count_from_meetup(group)
  #  init_rmeetup
  #  responses = RMeetup::Client.fetch(:groups,{:group_id => group.meetup_id})
  #  responses.each do |response|
  #    group.update_attributes( :members_count => response.try(:members) )
  #  end
  #end
  #
  #def self.create_events_from_meetup_api_response(response,group_id)
  #  event = Event.find_or_create_by_event_url_and_group_id(response.try(:event_url), group_id,
  #                                                         :event_id => response.try(:id),
  #                                                         :name => response.try(:name),
  #                                                         :meeting_at => response.try(:time),
  #                                                         :location_name => response.try(:venue).try(:[], 'name'),
  #                                                         :location_address => [response.try(:venue).try(:[], 'address_1'), response.try(:venue).try(:[], 'city'), response.try(:venue).try(:[], 'state')].compact.join(', '),
  #                                                         :event_url => response.try(:event_url)
  #                                                        )
  #  event.update_attributes( :yes_rsvp_count => response.try(:yes_rsvp_count) )
  #end
  #
  #def self.fetch_meetups_with_authentication(auth)
  #  init_rmeetup
  #  responses = RMeetup::Client.fetch( :groups,{ :fields => 'self', :member_id => auth.uid })
  #  meetups_added ||= []
  #  responses.each do |response|
  #    if response.try(:organizer).try(:[], 'member_id') == auth.uid || response.try(:self).try(:[], 'role').present?
  #      meetups_added << create_from_meetup_api_response(response)
  #    end
  #  end
  #  return meetups_added
  #rescue
  #  return meetups_added ||= []
  #end
  #
  #def self.create_from_meetup_api_response(response)
  #  group = Group.new
  #
  #  # Assign attributes from response
  #  group.name = response.try(:name) if response.try(:name) && group.name.blank?
  #  group.description = response.try(:description)
  #  group.meetup_id = response.try(:id)
  #  group.organizer_id = response.try(:organizer).try(:[], 'member_id')
  #  group.meetup_link = response.try(:link)
  #  group.city = response.try(:city)
  #  group.country_code = response.try(:country)
  #  group.province = response.try(:state)
  #  group.latitude = response.try(:lat)
  #  group.longitude = response.try(:lon)
  #  group.highres_photo_url = response.try(:group_photo).try(:[], 'highres_link')
  #  group.photo_url = response.try(:group_photo).try(:[], 'photo_link')
  #  group.thumbnail_url = response.try(:group_photo).try(:[], 'thumb_link')
  #  group.join_mode = response.try(:join_mode)
  #  group.visibility = response.try(:visibility)
  #  group.members_count = response.try(:members)
  #  group.save!
  #  return group
  #end
  #
  #def self.assign_groups_to_user(user, session)
  #  user.groups << session["auth"].groups if session["auth"] && !session["auth"].groups.blank?
  #  group = Group.find(session["group_to_assign"]) if session["group_to_assign"].present?
  #  user.groups << group unless group.blank?
  #end
  #
  #private
  #
  def self.init_rmeetup
    RMeetup::Client.api_key = ENV['MEETUP_API_KEY']
  end
  #
  #def self.clean_query(query)
  #  query = query.sub(/^https?\:\/\//, '').sub(/\/+$/,'')
  #  query = URI::parse("http://" + query).path.sub(/\/*/,"").sub(/\/+$/,'') if query.include?("meetup.com")
  #  query
  #end
  #
  #def self.query_method(query)
  #  if !!(query =~ /^[-+]?[0-9]+$/) # If the query is a number, assume it's a group_id
  #    return :group_id
  #  elsif query.include?("meetup.com")
  #    return :group_urlname
  #  else
  #    return :domain
  #  end
  #end

end