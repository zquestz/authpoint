require 'spec_helper'
require 'ostruct'

describe MainController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

end
