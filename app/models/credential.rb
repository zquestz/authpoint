class Credential < ActiveRecord::Base
  # Set default order alphebetically based on provider
  default_scope :order => 'provider ASC, id ASC'
  
  # Make sure essential data is present
  validates_presence_of :user, :provider, :uid

  # Belongs to a User.
  belongs_to :user
  
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

  # The provider name
  def provider_name
    provider_class.provider_name
  end

  # Update profile info from API
  def update_profile_info
    info = provider_class.new(self).profile_info
    self.update_attributes(info)
  end

  protected

  # Class that provides API interaction
  def provider_class
    "::Providers::#{self.provider.camelize}".constantize
  end
end