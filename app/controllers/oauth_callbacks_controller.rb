class OauthCallbacksController < ApplicationController
  skip_before_filter :require_login, :store_location
  before_filter :init_user, :except => [:failure, :logout]

  # Auth with google and other services.
  def google
    flash[:notice] = t(:auth_success, :scope => [:flash])
    redirect_back_or_default(root_path)
  end
  alias :facebook :google
  alias :twitter :google
  alias :tumblr :google

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
      if user = User.initialize_with_oauth_data(auth_data, current_user)
        setup_session(user.id)
      else
        flash[:error] = t(:create_user_error, :scope => [:flash])
        redirect_back_or_default(root_path)
      end
    else
      flash[:error] = t(:no_auth_data, :scope => [:flash])
      redirect_back_or_default(root_path)
    end
  end
end