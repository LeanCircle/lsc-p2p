class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  before_save { email.downcase! }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }

  has_many :role_assignments
  has_many :roles, through: :role_assignments
  has_one :peer

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  # Quick methods for accessing roles. I am lazy.
  def make_volunteer
    roles << Role.find_by_role("volunteer") unless roles.include?(Role.find_by_role("volunteer"))
  end

  def self.volunteers
    Role.find_by_role("volunteer").users
  end

  def make_organizer
    roles << Role.find_by_role("organizer") unless roles.include?(Role.find_by_role("organizer"))
  end

  def self.organizers
    Role.find_by_role("organizer").users
  end

  def self.team_members
    Role.find_by_role("team_member").users
  end

  def make_team_member
    roles << Role.find_by_role("team_member") unless roles.include?(Role.find_by_role("team_member"))
  end

  def self.peers
    Role.find_by_role("Peer").users
  end

  def make_peer
    roles << Role.find_by_role("Peer") unless roles.include?(Role.find_by_role("peer"))
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
