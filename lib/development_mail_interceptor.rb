class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "#{Rails.env} email to #{message.to} - #{message.subject}"
    message.to = ENV['INTERCEPT_EMAIL']
  end
end