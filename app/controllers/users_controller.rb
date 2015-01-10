class UsersController < ApplicationController
  include Mailchimp

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      subscribe(@user.email, @user.name) if @user.newsletter_subscription == true
      sign_in @user
      redirect_to links_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    was_subscribed = @user.newsletter_subscription
    old_email = @user.email
    if @user.update_attributes(user_params)
      is_subscribed = @user.newsletter_subscription
      if old_email != @user.email && @user.newsletter_subscription
        subscribe(@user.email, @user.name)
      elsif old_email == @user.email && is_subscribed != was_subscribed
        case is_subscribed
          when true
            subscribe(@user.email, @user.name)
          when false
            unsubscribe(@user.email)
        end
      end
      redirect_to registration_peer_path(@user.peer)
    else
      render 'edit'
    end
  end

  def team
    @team = (User.find_by_role(:team_member) + User.find_by_role(:volunteer)).uniq.shuffle
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :newsletter_subscription)
    end
end
