class ApplicationController < ActionController::Base
  # Include custom auth system. This is in extras/auth_system.rb
  include AuthSystem

  # Forgery protection, a rails default.
  protect_from_forgery
end
