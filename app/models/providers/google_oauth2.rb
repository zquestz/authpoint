class Providers::GoogleOauth2 < Providers::Default
  def initialize
    init_api_object
    discover_api
    super
  end

  def profile_info(credential)
    if update_token(credential)
      status, headers, body = @api_object.execute(
        @plus_api.people.get,
        'userId' => 'me'
      )
      profile = JSON.parse(body[0])

      attrs = { :profile_api_data => profile }
      attrs.merge!({ 
        :name => profile['displayName']
      }) if profile['displayName']

      attrs.merge!({ 
        :description => profile['tagline']
      }) if profile['tagline']

      attrs.merge!({ 
        :image => profile['image']['url']
      }) if profile['image'] && profile['image']['url']

      attrs
    end
  end

  def self.provider_name
    'Google'
  end

  protected

  def init_api_object
    @api_object ||= Google::APIClient.new(
      :authorization => :oauth_2,
      :host => 'www.googleapis.com',
      :http_adapter => HTTPAdapter::NetHTTPAdapter.new
    )
  end

  def discover_api
    @api_object.register_discovery_document(
      'plusPages', 'v1',
      open("#{Rails.root}/config/api/plusPages-v1.json") { |f| f.read }
    )

    @plus_api = @api_object.discovered_api('plusPages', 'v1')
  end

  def update_token(credential, options = {})
    return false unless credential.refresh_token && credential.token && credential.expires_at

    auth_info = @api_object.authorization.update_token!({
      :refresh_token => credential.refresh_token,
      :access_token => credential.token,
      :expires_in => credential.expires_at,
      :issued_at => credential.issued_at
    })

    if auth_info
      credential.token = auth_info.access_token
      credential.refresh_token = auth_info.refresh_token
      credential.expires_at = auth_info.expires_in
      credential.issued_at = auth_info.issued_at
      credential.save if options[:save] == true && credential.changed?
    end

    auth_info
  end
end