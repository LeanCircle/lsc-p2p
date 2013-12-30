class PeersController < ApplicationController
  include Mailchimp

  before_action :is_registered
  before_action :correct_user,      only: [:edit, :update, :registration]
  before_action :is_already_a_peer, only: [:new, :create]

  def new
  	@peer = current_user.create_peer
    session[:peer_step] = @peer.current_step
  end

  def create
  	@peer = current_user.build_peer(peer_params)
    if @peer.save
      if params[:back_button]
        redirect_to edit_user_path(current_user)
      else
        redirect_to registration_peer_path(@peer)
        @peer.next_step
        session[:peer_step] = @peer.current_step
      end
    else
      render 'new'
    end
  end

  def registration
    @peer = current_user.peer
    @peer.current_step = session[:peer_step]
  end

  def edit
  end

  def update
    @peer = current_user.peer
    @peer.current_step = session[:peer_step]

    if @peer.update_attributes(peer_params)
 
      if params[:submit_button]

        thank_peer

      elsif params[:stripeToken]

        token = params[:stripeToken]
        begin
          customer = Stripe::Customer.create(
            card: token,
            email: @peer.user.email,
            description: @peer.user.name
          )
          save_stripe_customer_id(:stripe_customer_id, customer.id)
          thank_peer
          flash[:tracking] = [["_trackEvent", "button", "submit", "peer-register-success"]]
        rescue Stripe::CardError => e
          flash.now[:danger] = e.message
          flash.now[:tracking] = [["_trackEvent", "button", "submit", "peer-stripe-fail-server"]]
          render 'registration'
        end

      elsif params[:back_button]
        change_step('previous')

      elsif params[:continue_button]
        change_step('next')
      end

    else
      render 'registration'
      flash.now[:tracking] = [["_trackEvent", "button", "submit", "peer-register-fail"]]
    end
  end

  private

    def peer_params
    	params.require(:peer).permit(:availability_location, :availability_time, :availability_team, :startup_info, :startup_role, :startup_market, :startup_persona, :startup_time, :startup_interviews, :startup_customers, :startup_pmf, :startup_metrics, :startup_stage, :runway_desc, :runway_milestone, :runway_constraints, :newsletter_subscription)
    end

    def save_stripe_customer_id(attribute, stripe_customer_id)
      @peer.user.update_attribute(attribute, stripe_customer_id)
    end

    def change_step(prev_or_next)
      case prev_or_next
        when 'previous'
        if @peer.first_step?
          redirect_to edit_user_path(current_user)
        else
          @peer.previous_step
          redirect_to registration_peer_path(current_user.peer)
        end
        when 'next'
          @peer.next_step
          redirect_to registration_peer_path(current_user.peer)
      end
      session[:peer_step] = @peer.current_step
    end

    def thank_peer
      UserMailer.registration_confirmed(@peer.user.email, @peer.user.name).deliver
      redirect_to thanks_path
      forget_user
      reset_session
    end

    # Before filters

    def correct_user
      @peer = Peer.find(params[:id])
      unless current_user.peer == @peer
        redirect_to registration_peer_path(current_user.peer)
        flash[:warning] = "You can't see that!"
      end
    end

    def is_already_a_peer
      if current_user.peer
        redirect_to registration_peer_path(current_user.peer)
        flash[:warning] = "Please complete your application"
      end
    end

end