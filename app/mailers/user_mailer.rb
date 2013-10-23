class UserMailer < ActionMailer::Base
  default from: "P2PC contact form <contact@p2p.leanstartupcircle.com>"

  def contact(message)
    @message = message
    mail to: "alessandroprioni@gmail.com",
         reply_to: @message.email,
         subject: "Message from P2PC contact form"
  end

end