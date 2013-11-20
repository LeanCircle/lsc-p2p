class SubscribersController < ApplicationController
  include Mailchimp

  def create
    if subscribe(subscriber_params[:email], subscriber_params[:name])
      redirect_to subscribers_thanks_path
    else
      redirect_to '/'
    end
  end

  private
    def subscriber_params
      params.require(:subscriber).permit(:name, :email)
    end
end
