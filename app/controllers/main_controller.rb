class MainController < ApplicationController
  before_filter :require_login, :only => :index
  
  # Home page
  def index
  end
  
  # Privacy policy
  def privacy
  end
end