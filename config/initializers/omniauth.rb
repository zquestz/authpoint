Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google, 'intrarts.com', 'azOZuu4NiQKmUHs8ddcdyS8Z', {:scope => 'http://www.google.com/m8/feeds/'}
end