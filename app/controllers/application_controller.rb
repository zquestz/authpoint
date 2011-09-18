class ApplicationController < ActionController::Base
  # Include custom auth system. This is in extras/auth_system.rb
  include AuthSystem

  # Forgery protection, a rails default.
  protect_from_forgery

  protected

  # Show template with links to supported oauth providers.
  # Once they login they will be forwarded to their requested resource.
  def require_login
    render :template => 'shared/login' unless logged_in?
  end
end
