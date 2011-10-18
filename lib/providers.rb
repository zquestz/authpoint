module Providers
  class Default
    # Stub out hash for profile info.
    # Should be overloaded in other provider classes
    def profile_info(credential)
      {}
    end
  end
end