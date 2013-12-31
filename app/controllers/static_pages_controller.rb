class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def contact
  end

  def team
    @team = (User.find_by_role(:team_member) + User.find_by_role(:volunteer)).uniq.shuffle
  end

  def thanks
  end

  def privacy
  end

  def p2p
  end
end
