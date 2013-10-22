class UserMailer < ActionMailer::Base
  default from: "alessandroprioni@gmail.com"

  def contact_us(message)
    @message = message
    mail to: "alessandroprioni@gmail.com",
         reply_to: @message.email,
         subject: "Message from P2PC contact form"
  end

end