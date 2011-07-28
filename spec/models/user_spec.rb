require 'spec_helper'

describe User do
  describe "basic creation" do
    it "should not create an empty user" do
      user = User.new
      user.should be_invalid
    end

    it "should save if we pass a provider and uid" do
      user = User.new(:provider => 'google', :uid => 'minimal@gmail.com')
      user.should be_valid
      user.save.should be_true
    end
  end

  describe "url generation" do
    it "should have nice param output" do
      user = Factory(:user)
      user.to_param.should == "#{user.id}-#{user.name}"
    end
  end

  describe "oauth import" do
    before do
      @auth_data = {
        'provider' => "google",
        'uid' => "someone@gmail.com",
        'user_info' => {
          'name' => "someone",
          'email' => "someone@gmail.com",
          'nickname' => nil,
          'first_name' => nil,
          'last_name' => nil,
          'location' => nil,
          'description' => nil,
          'image' => nil,
          'phone' => nil,
          'urls' => nil
        },
        'credentials' => {
          'token' => "TOKEN",
          'secret' => "SECRET"
        },
        'extra' => {
          'user_hash' => "---\nversion: '1.0'\nencoding: UTF-8\nfeed:\n  xmlns: h..."
        }
      }
    end

    it "should import auth data and return a user" do
      User.count.should == 0
      user = User.initialize_user_with_oauth_data(@auth_data)
      user.should be_valid
      User.count.should == 1
    end

    it "should import auth data and ignore extra data" do
      User.count.should == 0
      user = User.initialize_user_with_oauth_data(@auth_data.merge('extra_data' => 'extra'))
      user.should be_valid
      User.count.should == 1
    end

    it "should handle only receiving the provider and uid" do
      User.count.should == 0
      user = User.initialize_user_with_oauth_data({
        'provider' => 'google',
        'uid' => 'someone@gmail.com'
      })
      user.should be_valid
      User.count.should == 1
    end
  end
end