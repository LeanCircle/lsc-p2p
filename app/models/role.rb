class Role < ActiveRecord::Base
  has_many :role_assignments
  has_many :users, through: :role_assignments
  belongs_to :user

  def self.moderators
    Role.find_by_name("admin").users +
    Role.find_by_name("volunteer").users +
    Role.find_by_name("organizer").users +
    Role.find_by_name("team_member").users
  end
end
