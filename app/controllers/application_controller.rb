class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def mailchimp
  	Gibbon::API.new
  end

  rescue_from CanCan::AccessDenied do |exception|
    access_denied(exception)
  end

  def access_denied(exception)
    if current_user
      redirect_to root_path, :alert => exception.message
    else
      redirect_to sign_in_path, :alert => exception.message
    end
  end

  def redirect_back_or_default(default = root_path, *options)
    tag_options = {}
    options.first.each { |k,v| tag_options[k] = v } unless options.empty?
    redirect_to (request.referer.present? ? :back : default), tag_options
  end
  
end
