class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def contact
  end

  def team
    @team = (User.team_members + User.volunteers + User.volunteers).uniq.shuffle
  end

  def thanks
  end

  def privacy
  end

  def p2p
  end
end
