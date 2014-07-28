class Group < ActiveRecord::Base
  attr_accessor :meetup_identifier

  #belongs_to :authentication #, :primary_key => "id", :foreign_key => "auth_id" # TODO: scope this to :provider => "meetup"
  belongs_to :user
  has_many :events

  validates_presence_of :name
  validates_uniqueness_of :name,
                          :meetup_id,
                          :meetup_link, :allow_blank => true

  after_create :update_and_overwrite_from_meetup
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

  def update_and_overwrite_from_meetup
    Group.init_rmeetup
    method = Group.query_method(meetup_link)
    query = Group.clean_query(meetup_link)
    response = RMeetup::Client.fetch( :groups,{ method => query }).first
    overwrite_from_meetup_api_response(response) unless response.blank?
    fetch_events_from_meetup
  end

  def overwrite_from_meetup_api_response(response)
    # Assign attributes from response
    response.name ? update_attributes(name: response.name) : nil
    response.id ? update_attributes(meetup_id: response.id) : nil
    response.description ? update_attributes(description: response.description) : nil
    response.organizer["member_id"] ? update_attributes(organizer_id: response.organizer["member_id"]) : nil
    response.link ? update_attributes(meetup_link: response.link) : nil
    response.city ? update_attributes(city: response.city) : nil
    response.country ? update_attributes(country_code: response.country) : nil
    response.state ? update_attributes(province: response.state) : nil
    response.lat ? update_attributes(latitude: response.lat) : nil
    response.lon ? update_attributes(longitude: response.lon) : nil
    response.group_photo["highres_link"] ? update_attributes(highres_photo_url: response.group_photo["highres_link"]) : nil
    response.group_photo["photo_link"] ? update_attributes(photo_url: response.group_photo["photo_link"]) : nil
    response.group_photo["thumb_link"] ? update_attributes(thumbnail_url: response.group_photo["thumb_link"]) : nil
    response.join_mode ? update_attributes(join_mode: response.join_mode) : nil
    response.visibility ? update_attributes(visibility: response.visibility) : nil
    response.members ? update_attributes(members_count: response.members) : nil
    save!
  end

  def fetch_events_from_meetup
    Group.init_rmeetup
    responses = RMeetup::Client.fetch(:events,{:group_id => meetup_id, :status => 'past'})
    responses += RMeetup::Client.fetch(:events,{:group_id => meetup_id, :status => 'upcoming', :desc => true}).last(5)
    unless responses.blank?
      responses.each do |response|
         Event.create_or_update_event_from_meetup_api_response(response, id) unless response.blank?
      end
    end
  end
  #
  #def self.fetch_members_count_from_meetup(group)
  #  init_rmeetup
  #  responses = RMeetup::Client.fetch(:groups,{:group_id => group.meetup_id})
  #  responses.each do |response|
  #    group.update_attributes( :members_count => response.try(:members) )
  #  end
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

  def self.clean_query(query)
    query = query.sub(/^https?\:\/\//, '').sub(/\/+$/,'')
    query = URI::parse("http://" + query).path.sub(/\/*/,"").sub(/\/+$/,'') if query.include?("meetup.com")
    query
  end

  def self.query_method(query)
    if !!(query =~ /^[-+]?[0-9]+$/) # If the query is a number, assume it's a group_id
       return :group_id
    elsif query.include?("meetup.com")
       return :group_urlname
    else
       return :domain
    end
  end

end