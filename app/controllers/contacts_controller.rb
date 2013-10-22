class ContactsController < ApplicationController

  def new
    @message = Contact.new
  end

  def create
    @message = Contact.new(message_params)
    if verify_recaptcha(model: @message, :message => "Oh! It's error with reCAPTCHA!")
      UserMailer.contact(@message).deliver
      redirect_to(contact_thanks_path)
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
