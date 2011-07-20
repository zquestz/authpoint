require 'spec_helper'

describe OauthCallbacksController do

  describe "GET 'google'" do
    it "should be successful" do
      get 'google'
      response.should be_redirect
    end
  end
  
  describe "GET 'failure'" do
    it "should be successful" do
      get 'failure'
      response.should be_redirect
    end
  end

end
