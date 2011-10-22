class Post < ActiveRecord::Base
  # Add tagging support
  acts_as_taggable
  
  # Essential attributes, user and message.
  validates_presence_of :user, :message

  # All posts belong to a user
  belongs_to :user

  # Make sure user_id is never set via mass assignment
  attr_protected :user_id 

  # Attr accessor to store posting settings.
  attr_accessor :credential_ids
  
  # Paginate 20 per page
  self.per_page = 20

  # After save hook for posting
  after_save :post_to_credentials

  private

  def post_to_credentials
    self.user.credentials.each do |c|
      #if credential_ids.include?(c.id)
        c.post_content(self)
      #end
    end
  end
end
