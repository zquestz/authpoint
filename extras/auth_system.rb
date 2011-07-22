module AuthSystem

  # Mix in a few helpers and filters
  def AuthSystem.included(klass)
    klass.helper_method(:current_user, :current_provider, :current_uid, :logged_in?) if klass.methods.include?(:helper_method)

    # Store url to any pages we render correctly
    klass.after_filter(:store_location, :if => Proc.new {|c| c.request.format.html?}) if klass.methods.include?(:after_filter)
  end

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

  # Setup the session if we have a valid user.
  def setup_session(provider, uid)
    session[:provider], session[:uid] = [provider, uid]
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
end