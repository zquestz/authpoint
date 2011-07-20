require 'spec_helper'

describe User do
  it "should not create an empty user" do
    user = User.new
    user.should be_invalid
  end
  
  it "should save if we pass a provider and uid" do
    user = User.new(:provider => 'google', :uid => 'minimal@gmail.com')
    user.should be_valid
  end
end
