module Mailchimp
  extend ActiveSupport::Concern

  def subscribe(email, name)
    subscriber = Subscriber.new({ email: email, name: name})
    unless subscriber.save
      msgs = subscriber.errors.messages
      if msgs.has_key?(:email) and msgs[:email] == ['has already been taken']
        return true
      end
      return false
    end
    mailchimp.lists.subscribe({
      id: ENV['MAILCHIMP_LIST_ID'],
      email: {email: subscriber.email},
      merge_vars: {:FNAME => subscriber.name}
    })
    return true
  end

  def unsubscribe(email)
    Subscriber.find_by(email: email).destroy
    mailchimp.lists.unsubscribe(
      id: ENV['MAILCHIMP_LIST_ID'],
      email: {email: email},
      send_notify: true,
      send_goodbye: true
    )
  end
end
