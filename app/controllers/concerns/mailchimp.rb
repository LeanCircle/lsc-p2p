module Mailchimp
  extend ActiveSupport::Concern

  def subscribe(email, name)
    subscriber = Subscriber.new({ email: email, name: name})
    return false unless subscriber.save
    mailchimp.lists.subscribe({
      id: ENV['MAILCHIMP_LIST_ID'],
      email: {email: subscriber.email},
      merge_vars: {:FNAME => subscriber.name}
    })
    return true
  end
end
