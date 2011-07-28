require 'spec_helper'

describe Credential do
  describe "basic creation" do
    it "should not create an empty credential" do
      cred = Credential.new
      cred.should be_invalid
    end

    it "should save if we pass a valid user, provider, and uid" do
      user = Factory(:user)
      cred = Credential.new(:user =>user, :provider => 'google', :uid => 'minimal@gmail.com')
      cred.should be_valid
      cred.save.should be_true
    end
  end

  describe "url generation" do
    it "should have nice param output" do
      cred = Factory(:credential)
      cred.to_param.should == "#{cred.id}-#{cred.uid.parameterize}"
    end
  end
end
