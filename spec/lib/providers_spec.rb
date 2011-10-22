require 'spec_helper'

describe Providers do
  it "should have a profile_info method that takes a credential and returns an empty hash" do
    credential = Factory(:credential)
    provider = Providers::Default.new(credential)
    provider.respond_to?(:profile_info).should be_true
    provider.profile_info.should == {}
  end
end