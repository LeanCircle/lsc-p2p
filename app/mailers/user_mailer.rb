class UserMailer < ActionMailer::Base
  default from: "P2PC <mailer@p2p.leanstartupcircle.com>"

  def group_application(group)
    @group = group
    mail to: "Tristan@LeanStartupCircle.com",
         from: "New Group Application <feedback@leanstartupcircle.com>",
         subject: "[LSC] " + group.name
  end

  def contact(message)
    @message = message
    from = @message.name + "<" + @message.email + ">"
    mail to: "feedback@LeanStartupCircle.com",
         from: from,
         subject: "[LSC] Message from" + from
  end

  def daily_moderation(user)
    @user = user
    @links = Link.where(created_at: (Time.now - 1.day)..(Time.now))
    mail to: @user.email,
         from: "Tristan@LeanStartupCircle.com",
         subject: "Daily LSC moderator email"
  end

end