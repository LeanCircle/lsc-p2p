class UsersController < ApplicationController

  #before_action :is_registered,
  #              only: [:index, :edit, :update, :destroy]
  #before_action :correct_user,   only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      register @user
      @user.create_peer
      redirect_to registration_peer_path(@user.peer)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to registration_peer_path(@user.peer)
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :stripe_customer_id, :newsletter_subscription)
    end

    # Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
