class ProviderInfo
  extend ActiveSupport::Memoizable

  def settings
    config = YAML.load(File.read(File.join(Rails.root, 'config', 'providers.yml')))
    default_settings = config['default'] || {}
    env_settings = config[Rails.env] || {}
    default_settings.recursive_merge(env_settings)
  end
  memoize :settings
end