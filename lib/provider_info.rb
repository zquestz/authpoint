class ProviderInfo
  extend ActiveSupport::Memoizable

  def config_file
    File.join(Rails.root, 'config', 'providers.yml')
  end

  def settings
    config = YAML.load(File.read(config_file))
    default_settings = config['default'] || {}
    env_settings = config[Rails.env] || {}
    default_settings.recursive_merge(env_settings)
  rescue => e
    puts "#{e.message}" unless Rails.env.test?
    exit
  end
  memoize :settings
end