namespace :groups do

  desc "Updates each meetup and pulls in latest events"
  task update: :environment do
    Group.all.each do |group|
      group.update_and_overwrite_from_meetup
    end
  end

  desc "Updates all group events from meetup"
  task update_events: :environment do
    Group.all.each do |group|
      group.fetch_events_from_meetup
    end
  end

end
