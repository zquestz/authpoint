class Providers::Twitter < Providers::Default
  def initialize(cred)
    @credential = cred
    init_api_object
    super
  end

  def post_content(post)
    @api_object.update(post.message)
  end

  def provider_name
    'Twitter'
  end

  private

  def init_api_object
    Twitter.configure do |config|
      config.oauth_token = @credential.token
      config.oauth_token_secret = @credential.secret
    end

    # Initialize your Twitter client
    @api_object = Twitter::Client.new
  end
end