class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, ActiveAdmin::Page, :name => "Dashboard"
    can :read, :all

    if user.is? :peer
      can :manage, :links, :user_id => user.id
    end

    can :manage, :all if user.is? :admin

  end

end