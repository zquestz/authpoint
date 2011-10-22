class Providers::Facebook < Providers::Default
  def initialize(cred)
    @credential = cred
    init_api_object
    super
  end

  def profile_info
    profile = @api_object.get_object("me")

    attrs = { :profile_api_data => profile }
    attrs.merge!({
      :location => profile['location']['name']
    }) if profile['location'] && profile['location']['name']

    attrs
  rescue Koala::Facebook::APIError => e
    {}
  end

  def post_content(post)
    @api_object.put_object("me", "feed", :message => post.message)
  end

  def provider_name
    'Facebook'
  end

  private

  def init_api_object
    @api_object = Koala::Facebook::API.new(credential.token)
  end
end