class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :trackable
         :validatable

  before_save { email.downcase! }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true

  has_many :role_assignments
  has_many :roles, through: :role_assignments
  has_one :peer
  has_many :groups
  has_many :links

  acts_as_voter

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  # Quick methods for dealing with roles. I am lazy.

  def self.find_by_role(role_name)
    Role.find_by_name(role_name).try(:users)
  end

  def add_role(role_name)
    role = Role.find_by_name role_name
    roles << role unless roles.include? role
    is? role_name
  end

  def remove_role(role_name)
    role = Role.find_by_name role_name
    roles.delete role if roles.include? role
    !(is? role_name)
  end

  def is?(role_name)
    roles.include? Role.find_by_name role_name
  end

  def first_name
    name.sub(/ .*/, '')
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
