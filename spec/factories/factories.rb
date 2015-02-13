FactoryGirl.define do
  ###
  ## => Shared sequences
  ###
  sequence(:line1) {|n| "#{n} Harrison Street"}
  sequence(:line2) {|n| "Apt #{n}"}
  sequence(:locality) {|n| "#{n.ordinalize} Circle of Hezmana"}
  sequence(:company) {|n| "The #{n} FishShaped Dren Company"}
  sequence(:first_name) {|n| "Bo#{n}b"}
  sequence(:last_name) {|n| "Johnson#{n}"}
  sequence(:number) {|n| "#{n}"}
  sequence(:postal_usa) {|n| "#{n.to_s.rjust(5, '0')}"}
  sequence(:uid) {|n| "#{n.to_s.rjust(10, '0')}"}
  sequence(:name) {|n| "The Lean Startup Circle #{n}"}

  factory :group do
    user_id nil
    sequence(:meetup_id)
    organizer_id "10786373"
    name { FactoryGirl.generate :name }
    description "<p><strong>Lean Startup Circle</strong> is dedicat..."
    meetup_link { FactoryGirl.generate :uid }
    facebook_link ""
    twitter_link ""
    linkedin_link ""
    googleplus_link ""
    other_link ""
    city "San Francisco"
    country "United States"
    country_code "US"
    province "CA"
    latitude 37.7749295
    longitude -122.4194155
    gmaps nil
    highres_photo_url "http://photos3.meetupstatic.com/photos/event/4/2/6..."
    photo_url "http://photos3.meetupstatic.com/photos/event/4/2/6..."
    thumbnail_url "http://photos3.meetupstatic.com/photos/event/4/2/6..."
    join_mode "open"
    visibility "public"
    approval true
    lsc true
    members_count 5328
    slug { FactoryGirl.generate :uid }
    created_at "2014-08-04 19:18:59"
    updated_at "2014-08-04 19:18:59"
  end


  factory :event do
    start_datetime DateTime.now
    status 'past'
    group_id 1
    event_url {|n| "#{n}"}
    event_id {|n| "#{n}"}
    yes_rsvp_count {|n| n}
    created_at DateTime.now
    updated_at DateTime.now
  end
end
