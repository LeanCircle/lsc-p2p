class Peer < ActiveRecord::Base

  include Common
  attr_accessor :current_step
  
  belongs_to :user

  def current_step
    @current_step || steps.first
  end

  def steps
    %w[availability startup runaway payment]
  end

  def next_step
    @current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    @current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  protected
    def role_id
      "1"
    end

end