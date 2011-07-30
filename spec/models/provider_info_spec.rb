require 'spec_helper'

describe ProviderInfo do
  context "#settings" do
    it "should return a hash of provider data" do
      info = ProviderInfo.new.settings
      info.should be_a(Hash)
    end
  end
end