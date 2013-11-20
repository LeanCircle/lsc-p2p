module Mailchimp
  extend ActiveSupport::Concern

  def subscribe(email, name)
    mailchimp.lists.subscribe({
      id: ENV['MAILCHIMP_LIST_ID'],
      email: {email: email},
      merge_vars: {:FNAME => name}
    })
  end
end
