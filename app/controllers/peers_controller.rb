class PeersController < ApplicationController
  before_action :registered_peer, only: [:edit, :update]
  before_action :correct_peer,   only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :has_account, only: [:new, :create]

  def index
    @peers = Peer.order('name ASC')
  end

  def new
  	@peer = Peer.new
    @peer.current_step = session[:peer_step]
  end

  def show
  	@peer = Peer.find(params[:id])
  end

  def create
  	@peer = Peer.new(peer_params)
    if @peer.save
      register @peer
      redirect_to registration_peer_path(current_peer)
      @peer.next_step
      session[:peer_step] = @peer.current_step
    else
      render 'new'
    end
  end

  def registration
    @peer = current_peer
    @peer.current_step = session[:peer_step]
  end

  def edit
  end

  def update
    @peer.current_step = session[:peer_step]
    if @peer.update_attributes(peer_params)
      if params[:submit_button]
        flash[:success] = "Thanks!"
        redirect_to root_path
      else
        if params[:back_button]
          @peer.previous_step
        else
          @peer.next_step
        end
        redirect_to registration_peer_path(current_peer)
      end
      session[:peer_step] = @peer.current_step
    else
      render 'registration'
    end
  end

  def destroy
    Peer.find(params[:id]).destroy
    flash[:success] = "Peer destroyed."
    redirect_to peers_url
  end

  private

  def peer_params
  	params.require(:peer).permit(:name, :email, :availability_location, {availability_time: []}, :availability_team, :startup_info, :startup_role, :startup_market, :startup_persona, :startup_time, :startup_interviews, :startup_customers, :startup_pmf, :startup_metrics, {startup_stage: []}, :startup_stage, :runway_desc, :runway_milestone, :runway_constraints)
  end

  # Before filters

  def correct_peer
    @peer = Peer.find(params[:id])
    redirect_to(root_url) unless current_peer?(@peer)
    flash[:warning] = "You can't see that!" if !current_peer?(@peer)
  end

 # def admin_user
 #     redirect_to(users_url) unless current_user.admin?
 #     redirect_to(users_url) if User.find(params[:id]) == current_user
 # end

  def has_account
    if registered?
      redirect_to(root_url)
      flash[:warning] = "You are already registered!"
    end
  end
end