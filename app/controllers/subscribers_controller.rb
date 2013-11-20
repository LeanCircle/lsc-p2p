class SubscribersController < ApplicationController

  def create
    @subscriber = Subscriber.new(subscriber_params)

    if @subscriber.save
      redirect_to subscriber_thanks_path
    else
      render 'static_pages/home'
    end
  end

  private
    def subscriber_params
      params.require(:subscriber).permit(:name, :email)
    end
end
