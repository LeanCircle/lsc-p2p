class SubscribersController < ApplicationController
  include Mailchimp

  def create
    @subscriber = Subscriber.new(subscriber_params)

    if @subscriber.save
      subscribe(@subscriber.email, @subscriber.name)
      redirect_to subscribers_thanks_path
    else
      redirect_to 'static_pages/home'
    end
  end

  private
    def subscriber_params
      params.require(:subscriber).permit(:name, :email)
    end
end
