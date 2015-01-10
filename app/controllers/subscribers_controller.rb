class SubscribersController < ApplicationController
  include Mailchimp

  def landing_page
    redirect_to links_path if current_user
  end

  def create
    if subscribe(subscriber_params[:email], subscriber_params[:name])
      redirect_to thanks_subscribers_path
    else
      redirect_to '/'
    end
  end

  private
    def subscriber_params
      params.require(:subscriber).permit(:name, :email)
    end
end
