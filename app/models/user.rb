class User < ActiveRecord::Base
  validates_presence_of :provider, :uid
  
  # List only google accounts
  scope :google, :conditions => ['provider = ?', 'google']
  
  # Slug the url.
  def to_param
    "#{id}-#{name.parameterize}"
  end
  
  # Initialize User based on returned oauth data
  # More details at https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema
  def self.initialize_user_with_oauth_data(data)
    user = User.find_or_initialize_by_provider_and_uid(data['provider'], data['uid'])
    attrs = data['user_info']
    attrs.merge!(data['credentials'])
    attrs.merge!(data['extra'])
    attrs.delete_if {|k, v| !user.attributes.keys.include?(k)}
    user.update_attributes(attrs) ? user : false
  end
  
  # Count google accounts
  def self.google_count
    User.count(:conditions => ['provider = ?', 'google'])
  end
end
