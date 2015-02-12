%w[admin peer volunteer organizer team_member speaker good_reads_moderator].each do |role|
   Role.create(name: role) unless Role.find_by_name(role)
end

#Add at least one admin
[ { name: "Tristan Kromer", email: "tk@tristankromer.com" },
  { name: "Jourdan Bul-lalayao", email: "jpbullalayao@gmail.com" },
  { name: "Malcolm Anderson", email: "malcolm.b.anderson@gmail.com" },
  { name: "Sean K Murphy", email: "skmurphy@skmurphy.com" },
  { name: "Spike Morelli", email: "fsm@spikelab.org" }].each do |user|
  admin = User.find_or_create_by(email: user[:email])
  admin.name = user[:name]
  admin.email = user[:email]
  admin.add_role :admin
  admin.save
end

# Add some team members
[ { name: "Tristan Kromer", email: "tk@tristankromer.com" },
  { name: "Spike Morelli", email: "fsm@spikelab.org" },
  { name: "Sean K Murphy", email: "skmurphy@skmurphy.com" }].each do |user|
  team_member = User.find_or_create_by(email: user[:email])
  team_member.name = user[:name]
  team_member.email = user[:email]
  team_member.add_role :team_member
  team_member.save
end

# Add some volunteers
[ { name: "Tristan Kromer", email: "tk@tristankromer.com" },
  { name: "Spike Morelli", email: "fsm@spikelab.org" },
  { name: "Jeana Alayaay", email: "jeana.m.alayaay@gmail.com" },
  { name: "Erica Jayne Walsh", email: "Ericajayne.walsh@gmail.com" },
  { name: "John Gonzalez", email: "john@mywebroom.com" },
  { name: "Maureen Nonnenmann", email: "manonnen@gmail.com" },
  { name: "Janet Bumpas", email: "jjbumpas@gmail.com" },
  { name: "Javid Jamae", email: "javidjamae@gmail.com" },
  { name: "Rebecca Lippert", email: "beckadefalco@gmail.com" },
  { name: "Russel Miller", email: "russell@adamm.net" },
  { name: "Lisa Winter", email: "lisaw1@gmail.com" },
  { name: "Ryan MacCarrigan", email: "ryan.maccarrigan@gmail.com" },
  { name: "Malcolm Anderson", email: "malcolm.b.anderson@gmail.com" },
  { name: "Zac Halbert", email: "zachalbert@gmail.com" },
  { name: "Alessandro Prioni", email: "alessandroprioni@gmail.com" },
  { name: "Nick Noreña", email: "ninorena@gmail.com" },
  { name: "Karl Shaikh", email: "karl.shaikh@gmail.com" },
  { name: "Shilpa Pulipaka", email: "shilpa@shilpapulipaka.com" },
  { name: "Daniil Brodovich", email: "dbrodovich@gmail.com" },
  { name: "Thomas Rampelberg", email: "thomas@saunter.org" },
  { name: "Dan Stiefel", email: "danstiefel88@gmail.com" },
  { name: "Aaron Brown", email: "aaron.w.brown13@gmail.com" },
  { name: "Fardeen Rahaman", email: "fardeenrahaman@gmail.com" },
  { name: "Jeffrey Lorton", email: "jslorton@mac.com" },
  { name: "Eric Bell", email: "eric@ericbell.info" },
  { name: "Monique Barbanson", email: "mbarbanson@gmail.com" },
  { name: "Nikolaus Graf", email: "nik@blossom.io" },
  { name: "Josh Liu", email: "josh@acrossio.com" },
  { name: "Andreas Klinger", email: "ak@garmz.com" },
  { name: "Tim Dujon Rosenblatt", email: "tim@cloudspace.com" },
  { name: "James Bond", email: "james.bond.home@gmail.com" },
  { name: "Edith Harbaugh", email: "edith.harbaugh@gmail.com" },
  { name: "Keith Ratner", email: "keith.ratner@gmail.com" },
  { name: "Rich Collins", email: "richcollins@gmail.com" },
  { name: "Hiten Shah", email: "hnshah@gmail.com" },
  { name: "Sean K Murphy", email: "skmurphy@skmurphy.com" },
  { name: "Josh Liu", email: "josh@acrossio.com" } ].each do |user|
  volunteer = User.find_or_create_by(email: user[:email])
  volunteer.name = user[:name]
  volunteer.email = user[:email]
  volunteer.add_role :volunteer
  volunteer.save
end

case Rails.env
  when "development"
  # Add some fake groups
  10.times do |n|
    lat = rand(3771..3781)/1000.to_f
    long = rand(-12251..-12238)/1000.to_f
    Group.create(name: "awesome_group#{n}", facebook_link: "https://www.facebook.com/LeanStartupCircle", description: "group #{n} is great!", latitude: "#{lat}", longitude: "#{long}", approval: true)
  end

  # Add some fake articles
  i = 1
  while i < 28 do
    Link.create(title: "Article " + i.to_s, url: "http://google.com/"+i.to_s, reason: "Reason " + i.to_s, created_at: i.days.ago)
    i=i+1
  end
end






