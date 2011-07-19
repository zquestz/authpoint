require 'spec_helper'

describe OauthCallbacksController do

  describe "GET 'google'" do
    it "should be successful" do
      get 'google'
      response.should be_success
    end
  end

  describe "GET 'twitter'" do
    it "should be successful" do
      get 'twitter'
      response.should be_success
    end
  end

  describe "GET 'facebook'" do
    it "should be successful" do
      get 'facebook'
      response.should be_success
    end
  end

end
