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
    info = provider_class.profile_info
    self.update_attributes(info)
  end

  # Post content to network
  def post_content(post, options = {})
    provider_class.post_content(post)
  end

  protected

  # Class that provides API interaction
  def provider_class
    @provider_class ||= "::Providers::#{self.provider.camelize}".constantize.new(self)
  end
end