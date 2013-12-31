class ContactMessagesController < ApplicationController

  def new
    @message = ContactMessage.new
  end

  def create
    @message = ContactMessage.new(message_params)
    if @message.valid? && verify_recaptcha(model: @message, :message => "Oh! It's error with reCAPTCHA!")
      UserMailer.contact(@message).deliver
      redirect_to(contact_message_thanks_path)
    else
      render 'new'
    end
  end

  def thanks
  end

  private

  def message_params
    params.require(:contact).permit(:name, :email, :message)
  end

end  
