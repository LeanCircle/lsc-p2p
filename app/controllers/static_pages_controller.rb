class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def contact
  end

  def team
    @volunteers = User.volunteers.shuffle
  end

  def thanks
  end

  def privacy
  end

  def p2p
  end
end
