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
  { name: "Josh Liu", email: "josh@acrossio.com" }].each do |user|
  volunteer = User.find_by_email(user[:email]) || User.create(name: user[:name], email: user[:email])
  volunteer.make_volunteer
end