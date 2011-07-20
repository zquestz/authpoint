class OauthCallbacksController < ApplicationController
  before_filter :init_user, :except => [:failure, :logout]
  skip_after_filter :store_location
  
  # Auth with google
  def google
    flash[:notice] = t(:auth_success, :scope => [:flash])
    redirect_back_or_default(root_path)
  end
  
  # Failure route
  def failure
    flash[:error] = t(:auth_failed, :scope => [:flash])
    redirect_back_or_default(root_path)
  end
  
  # Logout, seems like an ok place to put this for now.
  def logout
    reset_session
    flash[:notice] = t(:logged_out, :scope => [:flash])
    redirect_back_or_default(root_path)
  end

  private
  
  # Get data from omniauth and create a user account.
  def init_user
    if auth_data = request.env['omniauth.auth']
      if user = User.initialize_user_with_oauth_data(auth_data)
        setup_session(user.provider, user.uid)
      else
        flash[:error] = t(:create_user_error, :scope => [:flash])
        redirect_back_or_default(root_path)
      end
    else
      flash[:error] = t(:no_auth_data, :scope => [:flash])
      redirect_back_or_default(root_path)
    end
  end
  
  # Setup the session if we have a valid user.
  def setup_session(provider, uid)
    session[:provider], session[:uid] = [provider, uid]
  end
end