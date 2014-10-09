namespace :links do

  desc "Send moderation email"
  task daily_moderation: :environment do
    UserMailer.daily_moderation(User.first).deliver
    # Role.moderators.each do |moderator|
    #   UserMailer.daily_moderation(moderator).deliver
    # end
  end

end
