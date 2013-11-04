class PeersController < ApplicationController
  before_action :correct_peer,   only: [:edit, :update, :registration]
  before_action :is_registered, only: [:new, :create]

  def new
  	@peer = Peer.new
    session[:peer_step] = @peer.current_step
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

        thank_peer

      elsif params[:stripeToken]

        token = params[:stripeToken]
        begin
          customer = Stripe::Customer.create(
            card: token,
            email: @peer.email,
            description: @peer.name
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
    	params.require(:peer).permit(:name, :email, :availability_location, :availability_time, :availability_team, :startup_info, :startup_role, :startup_market, :startup_persona, :startup_time, :startup_interviews, :startup_customers, :startup_pmf, :startup_metrics, :startup_stage, :runway_desc, :runway_milestone, :runway_constraints, :stripe_customer_id, :newsletter_subscription)
    end

    def save_stripe_customer_id(attribute, stripe_customer_id)
      @peer.update_attribute(attribute, stripe_customer_id)
    end

    def change_step(prev_or_next)
      case prev_or_next
        when 'previous'
          @peer.previous_step
        when 'next'
          @peer.next_step
      end
        
      redirect_to registration_peer_path(current_peer)
      session[:peer_step] = @peer.current_step
    end

    def thank_peer
      #mailchimp.lists.subscribe({id: ENV['MAILCHIMP_LIST_ID'], email: {email: @peer.email}, merge_vars: {:FNAME => @peer.name}}) if @peer.newsletter_subscription == true
      #UserMailer.registration_confirmed(@peer.email, @peer.name).deliver
      redirect_to thanks_path
      forget_peer
      reset_session
    end

    # Before filters

    def correct_peer
      @peer = Peer.find(params[:id])
      redirect_to(root_url) unless current_peer?(@peer)
      flash[:warning] = "You can't see that!" if !current_peer?(@peer)
    end

    def is_registered
      if registered?
        redirect_to registration_peer_path(current_peer)
        flash[:warning] = "Please complete your application"
      end
    end

end