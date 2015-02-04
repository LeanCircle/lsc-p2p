namespace :links do

  desc "Send moderation email"
  task daily_moderation: :environment do
    if Link.where(created_at: (Time.now - 1.day)..(Time.now)).count > 1
      User.find_by_role("good_reads_moderator").each do |moderator|
        UserMailer.daily_moderation(moderator).deliver
      end
    end
  end

  desc "Create weekly newsletter"
  task weekly_newsletter: :environment do
    mailchimp = Gibbon::API.new
    mailchimp.campaigns.create({ type: "regular",
                                 options: { list_id: ENV['MAILCHIMP_LIST_ID'],
                                            title: Time.now.strftime("%Y/%m/%d") + " Weekly Newsletter - Global",
                                            subject: Time.now.strftime("%b %e") +  " - Lean Startup Good Reads",
                                            from_email: "News@LeanStartupCircle.com",
                                            from_name: "Lean Startup Circle Weekly Newsletter",
                                            to_name: "*|FNAME|*",
                                            authenticate: true,
                                            tracking: { opens: true,
                                                        html_clicks: true,
                                                        text_clicks: true },
                                            analytics: { google: Time.now.strftime("%Y/%m/%d") + "-Weekly_Newsletter-Global" },
                                            auto_footer: true,
                                            template_id: 104821,
                                            inline_css: true,
                                            generate_text: true,
                                            auto_tweet: true,
                                            auto_fb_post: [ENV['FACEBOOK_PAGE_ID']],
                                            fb_comments: true
                                  },
                                 content: { sections: { body: ApplicationController.new.render_to_string(:template => 'user_mailer/weekly_newsletter', layout: false, :locals => { }) } }
                               })
  end

end
