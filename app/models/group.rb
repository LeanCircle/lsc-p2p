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
  scope :meetups, -> { where.not(meetup_link: ["", nil]) }
  scope :non_meetups, -> { where(meetup_link: ["", nil]) }
  scope :active, -> { includes(:events).where('meetup_link = NULL OR meetup_link = "" OR events.start_datetime >= ?', DateTime.now - 6.months).references(:events) }
  scope :nearest, ->(location) { near(location.coordinates, 5000) }

  def link
    [meetup_link,
     facebook_link,
     linkedin_link,
     googleplus_link,
     other_link,
     twitter_link].reject! { |c| c.blank? }.first
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
    unless meetup_link.blank?
      Rails.logger.info Group.init_rmeetup
      Rails.logger.info method = Group.query_method(meetup_link)
      Rails.logger.info query = Group.clean_query(meetup_link)
      Rails.logger.info response = RMeetup::Client.fetch( :groups,{ method => query }).first
      overwrite_from_meetup_api_response(response) unless response.blank?
      fetch_events_from_meetup
    end
  rescue Exception => e
    Rails.logger.error e.message
  end

  def overwrite_from_meetup_api_response(response)
    # Assign attributes from response
    update_attributes(name: response.try!(:name),
                      meetup_id: response.try!(:id),
                      description: response.try!(:description),
                      organizer_id: response.try!(:member_id),
                      meetup_link: response.try!(:link),
                      city: response.try!(:city),
                      province: response.try!(:state),
                      country_code: response.try!(:country),
                      latitude: response.try!(:lat),
                      longitude: response.try!(:lon),
                      highres_photo_url: response.try!(:group_photo).try!(:[],"highres_link"),
                      photo_url: response.try!(:group_photo).try!(:[],"photo_link"),
                      thumbnail_url: response.try!(:group_photo).try!(:[],"thumb_link"),
                      join_mode: response.try!(:join_mode),
                      visibility: response.try!(:visibility),
                      members_count: response.try!(:members))
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

  private

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
