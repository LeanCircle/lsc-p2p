%w[admin peer volunteer organizer team_member speaker].each do |role|
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
  { name: "Jourdan Bul-lalayao", email: "jpbullalayao@gmail.com" },
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