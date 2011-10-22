class Providers::Facebook < Providers::Default
  def profile_info
    @api_object = Koala::Facebook::API.new(credential.token)

    profile = @api_object.get_object("me")

    attrs = { :profile_api_data => profile }
    attrs.merge!({
      :location => profile['location']['name']
    }) if profile['location'] && profile['location']['name']

    attrs
  rescue Koala::Facebook::APIError => e
    {}
  end

  def provider_name
    'Facebook'
  end
end