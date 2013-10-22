class ContactsController < ApplicationController

  def new
    @message = Contact.new
  end

  def create
    @message = Contact.new(message_params)
    if @message.valid?
      UserMailer.contact_us(@message).deliver
      flash[:success] = "Message sent!"
      redirect_to(root_path)
    else
      render 'new'
    end
  end

  private

  def message_params
    params.require(:contact).permit(:name, :email, :message)
  end

end  
