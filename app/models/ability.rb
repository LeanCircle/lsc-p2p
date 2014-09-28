class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :manage, :all if user.is? :admin
    if user.is? :peer
      can :manage, :posts, :user_id => user.id
    end
    can :read, ActiveAdmin::Page, :name => "Dashboard"
    can :read, :all
  end

end