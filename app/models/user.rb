class User < ActiveRecord::Base
  validates_presence_of :name

  # Can have many oauth credentials
  has_many :credentials

  # Slug the url.
  def to_param
    "#{id}-#{name.parameterize}"
  end

  # Initialize based on returned oauth data.
  # This will create a Credential record if needed.
  # More details at https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema
  def self.initialize_with_oauth_data(data, current_user)
    credential = Credential.find_or_initialize_by_provider_and_uid(data['provider'], data['uid'])
    attrs = data['user_info'] || {}
    attrs.merge!(data['credentials']) if data['credentials']
    attrs.merge!(data['extra']) if data['extra']
    attrs.delete_if { |k, v| !credential.attributes.keys.include?(k) }
    credential.attributes = attrs
    user = current_user || credential.user || User.new(:name => credential.uid)
    credential.user = user
    user.credentials << credential
    user.save ? user : false
  end
end