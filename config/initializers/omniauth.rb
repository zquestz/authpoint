# Bring in ProviderInfo class that interfaces with config/providers.yml.
require 'provider_info'

# Instantiate ProviderInfo class.
# YAML data is returned by the settings method.
pinfo = ProviderInfo.new.settings

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google, pinfo['google']['key'], pinfo['google']['secret'], {
    :scope => pinfo['google']['scope']
  }
  
  provider :facebook, pinfo['facebook']['key'], pinfo['facebook']['secret'], {
    :scope => pinfo['facebook']['scope']
  }
end