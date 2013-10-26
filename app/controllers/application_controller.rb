class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include PeersHelper

  def mailchimp
  	Gibbon::API.new
  end

  def p2pc_list_id
  	'bf518a7f46'
  end
  
end
