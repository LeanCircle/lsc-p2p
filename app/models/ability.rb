class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.encrypted_password? # If user has a password, they are a registered user.
      can :manage, Link, :user_id => user.id  # TODO: Fix this.
      can [:new, :create], Link
    end

    can :manage, :all if user.is? :admin

    can :read, ActiveAdmin::Page, name: "Dashboard"
    can :read, :all
    cannot :new, Link
  end

end