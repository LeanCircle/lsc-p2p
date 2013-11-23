class User < ActiveRecord::Base

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

  def self.team_member
    Role.find_by_role("team_member").users
  end

  def self.volunteers
    Role.find_by_role("volunteer").users
  end

  def self.organizers
    Role.find_by_role("organizer").users
  end

  def self.peers
    Role.find_by_role("Peer").users
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
