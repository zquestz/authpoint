module Providers
  class Default
    MAX_RETRIES = 1

    attr_accessor :credential

    def initialize(cred)
      @credential ||= cred
    end

    # Stub out hash for profile info.
    # Should be overloaded in other provider classes
    def profile_info
      {}
    end

    # Post content to the provider
    # Should be overloaded in other provider classes
    def post_content(post)
      nil
    end

    # Friendly name for the provider.
    def provider_name
      'Default'
    end
  end

  class MaxRetriesExceeded < Exception
  end

  class ApiError < Exception
  end
end