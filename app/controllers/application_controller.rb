class ApplicationController < ActionController::Base
  after_filter :store_location, :if => Proc.new {|c| c.request.format.html?}
  
  protect_from_forgery
  
  helper_method :current_user, :current_provider, :current_uid, :logged_in?

  # Get current user
  def current_user
    if current_provider && current_uid
      @current_user ||= User.find_by_provider_and_uid(current_provider, current_uid)
    else
      @current_user = nil
    end
  end
  
  # User logged in?
  def logged_in?
    current_user ? true : false
  end
  
  # Get current provider
  def current_provider
    session[:provider]
  end
  
  # Get current uid
  def current_uid
    session[:uid]
  end
  
  # Store a url in the session that is safe to go back to (non-volatile)
  def store_location
    session[:return_to] = request.fullpath
  end
  
  # Redirect back to last good page, or the page you pass it if it doesn't know where to go.
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
    return
  end
  
  # Get plain id value from slugged attribute
  def strip_slug(param)
    param.split('-').first
  end
end
