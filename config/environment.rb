# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
P2pc::Application.initialize!

#ActionMailer::Base.smtp_settings = {
#  :user_name => ENV['SENDGRID_USERNAME'],
#  :password => ENV['SENDGRID_PASSWORD'],
#  :domain => ENV['SENDGRID_DOMAIN'],
#  :address => 'smtp.sendgrid.net',
#  :port => 587,
#  :authentication => :plain,
#  :enable_starttls_auto => true
#}

ActionMailer::Base.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  user_name:            'alessandroprioni@gmail.com',
  password:             'am040208',
  authentication:       'plain',
  enable_starttls_auto: true  }