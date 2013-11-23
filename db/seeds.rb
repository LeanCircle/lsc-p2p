%w[Peer volunteer organizer team_member].each do |param|
   Role.create(role: param) unless Role.find_by_role(param).nil?
end

# Add some team members
[ { name: "Tristan Kromer", email: "tk@tristankromer.com" },
  { name: "Spike Morelli", email: "fsm@spikelab.org" }].each do |user|
  volunteer = User.find_by_email(user[:email]) || User.create(name: user[:name], email: user[:email])
  volunteer.make_team_member
end

# Add some volunteers
[ { name: "Zac Halbert", email: "zachalbert@gmail.com" },
  { name: "Alessandro Prioni", email: "alessandroprioni@gmail.com" },
  { name: "Nick Noreña", email: "ninorena@gmail.com" },
  { name: "Karl Shaikh", email: "karl.shaikh@gmail.com" },
  { name: "Shilpa Pulipaka", email: "shilpa@shilpapulipaka.com" },
  { name: "Daniil Brodovich", email: "dbrodovich@gmail.com" },
  { name: "Thomas Rampelberg", email: "thomas@saunter.org" },
  { name: "Dan Stiefel", email: "danstiefel@gmail.com" },
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
  { name: "Josh Liu", email: "josh@acrossio.com" }].each do |user|
  volunteer = User.find_by_email(user[:email]) || User.create(name: user[:name], email: user[:email])
  volunteer.make_volunteer
end