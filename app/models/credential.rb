class Credential < ActiveRecord::Base
  validates_presence_of :user, :provider, :uid

  # Belongs to a User.
  belongs_to :user
  
  # Is it a facebook credential?
  def facebook?
    self.provider == 'facebook'
  end
  
  # Is it a google credential?
  def google?
    self.provider == 'google'
  end
  
  # Is it a twitter credential?
  def twitter?
    self.provider == 'twitter'
  end

  # Slug the url.
  def to_param
    "#{id}-#{uid.parameterize}"
  end
end