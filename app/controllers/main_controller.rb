class MainController < ApplicationController
  before_filter :require_login, :only => :index
  
  # Privacy policy
  def privacy
  end
end