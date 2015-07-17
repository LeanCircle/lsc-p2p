# Preview mailer by going to: http://localhost:3000/rails/mailers/user_mailer/daily_moderation
class UserMailerPreview < ActionMailer::Preview
  def daily_moderation
    ::UserMailer.daily_moderation(User.first)
  end
end
