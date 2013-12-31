class UserMailer < ActionMailer::Base
  default from: "P2PC <mailer@p2p.leanstartupcircle.com>"

  def group_application(group)
    @group = group
    mail to: "tristan@leanstartupcircle.com",
         from: "New Group Application <info@leanstartupcircle.com>",
         subject: "New Group in " + group.name
  end

  def contact(message)
    @message = message
    from = @message.name + "<" + @message.email + ">"
    mail to: "feedback@leanstartupcircle.com",
         from: from,
         subject: "[LSC] Message from" + from
  end

  def registration_confirmed(peer_email, peer_name)
    @name = peer_name.titleize
    mail to: peer_email,
         reply_to: "p2p@leanstartupcircle.com",
         subject: "Thanks #{@name}! Your invite has been requested :)"
  end

end