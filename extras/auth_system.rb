module AuthSystem
  # Mix in a few helpers and filters
  def AuthSystem.included(klass)
    klass.helper_method(:current_user, :current_user_id, :logged_in?) if klass.methods.include?(:helper_method)

    # Store url to any pages we render correctly
    klass.before_filter(:store_location, :if => Proc.new { |c| c.request.format.html? }) if klass.methods.include?(:before_filter)
  end

  # Get current user
  def current_user
    if current_user_id
      @current_user ||= User.find(current_user_id, :include => :credentials)
    else
      @current_user = nil
    end
  end

  # User logged in?
  def logged_in?
    current_user ? true : false
  end

  # Get current provider
  def current_user_id
    session[:user_id]
  end

  # Setup the session if we have a valid user.
  def setup_session(user_id)
    session[:user_id] = user_id
  end

  # Store a url in the session that is safe to go back to (non-volatile)
  def store_location
    session[:return_to] = request.fullpath
  end

  # Redirect back to last good page, or the page you pass it if it doesn't know where to go.
  def redirect_back_or_default(default)
    location = session[:return_to] || default
    location = default if location == request.fullpath
    redirect_to(location)
    session[:return_to] = nil
    return
  end
end