namespace :links do

  desc "Send moderation email"
  task daily_moderation: :environment do
    if Link.where(created_at: (Time.now - 1.day)..(Time.now)).count > 1
      User.find_by_role("good_reads_moderator").each do |moderator|
        UserMailer.daily_moderation(moderator).deliver
      end
    end
  end

end
