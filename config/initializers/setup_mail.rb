ActionMailer::Base.smtp_settings = {
  user_name: ENV['SMTP_USERNAME'],
  password: ENV['SMTP_PASSWORD'],
  domain: ENV['SMTP_DOMAIN'],
  address: ENV['SMTP_ADDRESS'],
  port: ENV['SMTP_PORT'],
  authentication: ENV['SMTP_AUTHENTICATION'],
  enable_starttls_auto: ENV['SMTP_STARTTLS']  }

if  Rails.env.development? || Rails.env.staging?
  require 'development_mail_interceptor'
  ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor)
end