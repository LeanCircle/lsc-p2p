class UserMailer < ActionMailer::Base
  default from: "P2PC <mailer@p2p.leanstartupcircle.com>"

  def contact(message)
    @message = message
    mail to: "alessandroprioni@gmail.com",
         from: "P2PC contact form <contact@p2p.leanstartupcircle.com>",
         reply_to: @message.email,
         subject: "Message from P2PC contact form"
  end

  def registration_confirmed(peer_email, peer_name)
    @name = peer_name.titleize
    mail to: peer_email,
         reply_to: "alessandroprioni@gmail.com",
         subject: "Thanks #{@name}! Your invite has been requested :)"
  end

end