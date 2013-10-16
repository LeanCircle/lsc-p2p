class Peer < ActiveRecord::Base
  attr_accessor :current_step
	
	before_save { peer_email.downcase! }
	before_create :create_remember_token

	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true, uniqueness: { case_sensitive: false },
										format: { with: VALID_EMAIL_REGEX }

  serialize :availability_time
  serialize :startup_stage

	def self.new_remember_token
   	SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def current_step
    @current_step || steps.first
  end

  def steps
    %w[info availability startup runway]
  end

  def next_step
    @current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  private

    def create_remember_token
      self.remember_token = Peer.encrypt(Peer.new_remember_token)
    end
end