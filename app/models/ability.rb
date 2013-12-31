class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :manage, :all if user.is? :admin
    can :read, ActiveAdmin::Page, :name => "Dashboard"
  end

end