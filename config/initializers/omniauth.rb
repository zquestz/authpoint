# Bring in ProviderInfo class that interfaces with config/providers.yml.
require 'provider_info'

# Instantiate ProviderInfo class.
# YAML data is returned by the settings method.
pinfo = ProviderInfo.new.settings

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google, pinfo['google']['key'], pinfo['google']['secret'], {
    :scope => 'http://www.google.com/m8/feeds https://www.googleapis.com/auth/buzz'
  }
end