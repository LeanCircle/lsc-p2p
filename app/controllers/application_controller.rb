class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def mailchimp
  	Gibbon::API.new
  end

  def access_denied(exception)
    redirect_to sign_in_path, :alert => exception.message
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to sign_in_path, :alert => exception.message
  end

  def redirect_back_or_default(default = root_path, *options)
    tag_options = {}
    options.first.each { |k,v| tag_options[k] = v } unless options.empty?
    redirect_to (request.referer.present? ? :back : default), tag_options
  end
  
end
