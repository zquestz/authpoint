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

    def self.provider_name
      'Default'
    end
  end

  class MaxRetriesExceeded < Exception
  end

  class ApiError < Exception
  end
end