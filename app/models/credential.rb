class Credential < ActiveRecord::Base
  # Set default order alphebetically based on provider
  default_scope :order => 'provider ASC'
  
  # Make sure essential data is present
  validates_presence_of :user, :provider, :uid

  # Belongs to a User.
  belongs_to :user

  # Update profile information before saving
  before_save :update_profile_info
  
  # Is it a facebook credential?
  def facebook?
    self.provider == 'facebook'
  end
  
  # Is it a google credential?
  def google?
    ['google_oauth2', 'google'].include?(self.provider)
  end
  
  # Is it a twitter credential?
  def twitter?
    self.provider == 'twitter'
  end
  
  # Is it a tumblr credential?
  def tumblr?
    self.provider == 'tumblr'
  end

  # Slug the url.
  def to_param
    "#{id}-#{uid.parameterize}"
  end

  protected

  def update_profile_info
    self.attributes = eval("::Providers::#{self.provider.camelize}.new.profile_info(self)")
  end
end