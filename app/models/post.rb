class Post < ActiveRecord::Base
  # Add tagging support
  acts_as_taggable
  
  # Essential attributes, user and message.
  validates_presence_of :user, :message

  # All posts belong to a user
  belongs_to :user

  # Make sure user_id is never set via mass assignment
  attr_protected :user_id 
  
  # Paginate 20 per page
  self.per_page = 20
end
