class MainController < ApplicationController
  before_filter :require_login, :only => :index
  
  def index
  end
  
  def privacy
  end
end